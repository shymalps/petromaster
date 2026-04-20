import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../../../app/Di/dimensions.dart';
import '../../../../shared/view/animatedlistview.dart';
import '../../../../shared/view/nodatafound.dart';
import '../../../viewmodel/audiolistvm.dart';

class Audiolist extends StatefulWidget {
  const Audiolist({super.key});

  @override
  State<Audiolist> createState() => _AudiolistState();
}

class _AudiolistState extends State<Audiolist> {
  final AudioPlayer _player = AudioPlayer();
  int _currentIndex = -1;
  bool _isSeeking = false;

  double _getProgress(Duration position, Duration duration) {
    if (duration.inMilliseconds == 0) return 0;
    return position.inMilliseconds / duration.inMilliseconds;
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void initState() {
    super.initState();

    _player.playerStateStream.listen((state) {
      if (!mounted) return;
      setState(() {});
    });

    // Listen for completion to auto-move to next
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        _playNext();
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _playAudio(String url, int index) async {
    try {
      if (_currentIndex == index) {
        if (_player.playing) {
          await _player.pause();
        } else {
          await _player.play();
        }
        return;
      }

      _currentIndex = index;
      await _player.stop();
      await _player.setUrl(url);
      await _player.play();
      setState(() {});
    } catch (e) {
      debugPrint("Audio Error: $e");
    }
  }

  // ✅ SKIP FORWARD 10 seconds
  Future<void> _skipForward() async {
    final currentPosition = _player.position;
    final duration = _player.duration ?? Duration.zero;
    final newPosition = currentPosition + const Duration(seconds: 10);

    if (newPosition < duration) {
      setState(() => _isSeeking = true);
      await _player.seek(newPosition);
      setState(() => _isSeeking = false);
    } else {
      await _player.seek(duration);
    }
  }

  // ✅ SKIP BACKWARD 10 seconds
  Future<void> _skipBackward() async {
    final currentPosition = _player.position;
    final newPosition = currentPosition - const Duration(seconds: 10);

    setState(() => _isSeeking = true);
    if (newPosition > Duration.zero) {
      await _player.seek(newPosition);
    } else {
      await _player.seek(Duration.zero);
    }
    setState(() => _isSeeking = false);
  }

  // ✅ PLAY NEXT AUDIO
  Future<void> _playNext() async {
    final audioVM = Get.find<Audiolistvm>();
    if (_currentIndex < audioVM.audiolist.length - 1) {
      final nextIndex = _currentIndex + 1;
      final nextAudio = audioVM.audiolist[nextIndex];
      await _playAudio(nextAudio.name ?? "", nextIndex);
    }
  }

  // ✅ PLAY PREVIOUS AUDIO
  Future<void> _playPrevious() async {
    final audioVM = Get.find<Audiolistvm>();
    if (_currentIndex > 0) {
      final prevIndex = _currentIndex - 1;
      final prevAudio = audioVM.audiolist[prevIndex];
      await _playAudio(prevAudio.name ?? "", prevIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final audioVM = Get.find<Audiolistvm>();

    return Obx(() {
      if (audioVM.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (audioVM.audiolist.isEmpty) {
        return const Emptypage();
      }

      return Padding(
        padding: EdgeInsets.all(Di.screenWidth * 0.02),
        child: AnimatedListView(
          itemcount: audioVM.audiolist.length,
          itemBuilder: (context, index, animation) {
            final audio = audioVM.audiolist[index];
            final isCurrent = _currentIndex == index;
            final isPlaying = isCurrent && _player.playing;

            return FadeTransition(
              opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
              child: Card(
                elevation: isCurrent ? 4 : 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: isCurrent
                      ? BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        )
                      : BorderSide.none,
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        try {
                          await audioVM.audioseen(audio.audioId.toString());
                        } catch (e) {}

                        _playAudio(audio.name ?? "", index);
                      },
                      child: ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                              color: isPlaying
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                                icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color:
                                      isPlaying ? Colors.white : Colors.black87,
                                ),
                                onPressed: () => null
                                // _playAudio(audio.name ?? "", index),
                                ),
                          ),
                          title: Text(
                            audio.audioName ?? "Audio",
                            style: TextStyle(
                              fontWeight: isCurrent
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          subtitle: Text(
                            isPlaying ? "Playing..." : "Tap to Play",
                            style: TextStyle(
                              color: isPlaying
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey[600],
                            ),
                          ),
                          trailing: isCurrent
                              ? null
                              // ? Icon(Icons.volume_up,
                              //     color: Theme.of(context).primaryColor)
                              : null
                          // const Icon(Icons.music_note, color: Colors.grey),
                          ),
                    ),

                    // ✅ ENHANCED CONTROLS FOR CURRENT PLAYING AUDIO
                    if (isCurrent)
                      StreamBuilder<Duration>(
                        stream: _player.positionStream,
                        builder: (context, snapshot) {
                          final position = snapshot.data ?? Duration.zero;
                          final duration = _player.duration ?? Duration.zero;
                          final progress = _getProgress(position, duration);

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Column(
                              children: [
                                // ✅ SLIDER FOR SEEKING
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 3,
                                    thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 6,
                                    ),
                                    overlayShape: const RoundSliderOverlayShape(
                                      overlayRadius: 12,
                                    ),
                                  ),
                                  child: Slider(
                                    value: progress.clamp(0.0, 1.0),
                                    onChanged: (value) async {
                                      final newPosition = duration * value;
                                      setState(() => _isSeeking = true);
                                      await _player.seek(newPosition);
                                      setState(() => _isSeeking = false);
                                    },
                                  ),
                                ),

                                // ✅ TIME DISPLAY
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _formatDuration(position),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      if (_isSeeking)
                                        const SizedBox(
                                          height: 12,
                                          width: 12,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      Text(
                                        _formatDuration(duration),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // ✅ CONTROL BUTTONS ROW
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Previous Track
                                    // IconButton(
                                    //   icon: const Icon(Icons.skip_previous),
                                    //   onPressed:
                                    //       _currentIndex > 0 ? _playPrevious : null,
                                    //   color: Theme.of(context).primaryColor,
                                    //   iconSize: 28,
                                    // ),

                                    // Skip Backward 10s
                                    IconButton(
                                      icon: const Icon(Icons.replay_10),
                                      onPressed: _skipBackward,
                                      color: Theme.of(context).primaryColor,
                                      iconSize: 32,
                                    ),

                                    // Play/Pause (Main Control)
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                        onPressed: () =>
                                            _playAudio(audio.name ?? "", index),
                                        iconSize: 32,
                                      ),
                                    ),

                                    // Skip Forward 10s
                                    IconButton(
                                      icon: const Icon(Icons.forward_10),
                                      onPressed: _skipForward,
                                      color: Theme.of(context).primaryColor,
                                      iconSize: 32,
                                    ),

                                    // Next Track
                                    // IconButton(
                                    //   icon: const Icon(Icons.skip_next),
                                    //   onPressed: _currentIndex <
                                    //           audioVM.audiolist.length - 1
                                    //       ? _playNext
                                    //       : null,
                                    //   color: Theme.of(context).primaryColor,
                                    //   iconSize: 28,
                                    // ),
                                  ],
                                ),

                                const SizedBox(height: 8),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
