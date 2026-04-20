import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../app/config/theme/text.dart';

class CountdownTimer extends StatefulWidget {
  final int time;
  final Function(bool) onTimerFinish; // Callback function

  const CountdownTimer({
    super.key,
    required this.time,
    required this.onTimerFinish,
  });

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late int _countdown; // Initial countdown value in seconds

  @override
  void initState() {
    super.initState();
    _countdown = widget.time * 60; // Convert minutes to seconds
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_countdown == 0) {
          timer.cancel();
          // Invoke callback with true when timer finishes
          widget.onTimerFinish(true);
        } else {
          setState(() {
            _countdown--;
          });
        }
      },
    );
  }

  String _formatTime(int seconds) {
    int minutes = (seconds ~/ 60);
    int remainingSeconds = (seconds % 60);
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return AppTextHelper.mainHead(
      text: _formatTime(_countdown),
      fontWeight: FontWeight.bold,
    );
  }
}