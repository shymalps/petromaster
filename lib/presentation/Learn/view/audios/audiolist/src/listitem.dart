import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../../../app/Di/dimensions.dart';
import '../../../../../shared/view/animatedlistview.dart';
import '../../../../../shared/view/nodatafound.dart';
import '../../../../viewmodel/audiolistvm.dart';

class Audiolist extends StatefulWidget {
  const Audiolist({super.key});

  @override
  State<Audiolist> createState() => _AudiolistState();
}

class _AudiolistState extends State<Audiolist> {
  final AudioPlayer _player = AudioPlayer();
  int _currentIndex = -1;
  bool _isPlaying = false;

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _playAudio(String url, int index) async {
    try {
      if (_currentIndex == index && _isPlaying) {
        await _player.pause();
        setState(() => _isPlaying = false);
      } else {
        await _player.setUrl(url);
        await _player.play();
        setState(() {
          _currentIndex = index;
          _isPlaying = true;
        });
      }
    } catch (e) {
      debugPrint("Audio Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final audioVM = Get.find<Audiolistvm>();

    return Obx(
      () {
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
              final isPlaying = isCurrent && _isPlaying;

              return FadeTransition(
                opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
                child: Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.blue,
                      ),
                    ),
                    title: Text(
                      audio.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      "Tap to ${isPlaying ? "Pause" : "Play"}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: isPlaying
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.music_note),
                    onTap: () {
                      _playAudio(audio.name ?? "", index);
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
