import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:track_me/app/features/activity_timer/widgets/timer_controls.dart';
import 'package:track_me/app/features/activity_timer/widgets/timer_time.dart';

class Timer extends StatelessWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          TimerTime(),
          SizedBox(height: 20),
          TimerControls(),
        ],
      ),
    );
  }
}
