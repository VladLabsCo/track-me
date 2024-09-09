import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/features/home/providers/timer_provider.dart';

class TimerTime extends ConsumerWidget {
  const TimerTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _TimerTimeConsumer(ref.watch(timerNotifierProvider));
  }
}

class _TimerTimeConsumer extends StatefulWidget {
  const _TimerTimeConsumer(this.timerState);

  final TimerState timerState;

  @override
  State<_TimerTimeConsumer> createState() => _TimerTimeConsumerState();
}

class _TimerTimeConsumerState extends State<_TimerTimeConsumer> {
  String _timeHM = '0:00';
  String _timeS = '00';

  Timer? _timer;

  @override
  void didUpdateWidget(covariant _TimerTimeConsumer oldWidget) {
    switch (widget.timerState.clockState) {
      case TimerClockState.initial:
        _resetTimer(
          oldWidget.timerState.clockState == TimerClockState.running,
        );
      case TimerClockState.running:
        _startTimer(
          widget.timerState.runDate!,
          widget.timerState.durationAtPause,
        );
      case TimerClockState.paused:
        _stopTimer();
    }

    super.didUpdateWidget(oldWidget);
  }

  void _resetTimer(bool wasRunning) {
    if (wasRunning) _timer!.cancel();

    setState(() {
      _timeHM = '0:00';
      _timeS = '00';
      if (wasRunning) _timer = null;
    });
  }

  void _startTimer(DateTime runDate, Duration durationAtPause) {
    setState(() {
      _timer ??= Timer.periodic(
        const Duration(seconds: 1),
        (_) => _getSetTime(runDate, durationAtPause),
      );
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();

      setState(() {
        _timer = null;
      });
    }
  }

  void _getSetTime(DateTime runDate, Duration durationAtPause) {
    final now = DateTime.now();
    final difference = now.difference(runDate) + durationAtPause;

    final hours = difference.inHours.toString();
    final minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (difference.inSeconds % 60).toString().padLeft(2, '0');

    setState(() {
      _timeHM = '$hours:$minutes';
      _timeS = seconds;
    });
  }

  final clockTextStyle = const TextStyle(
    fontSize: 50,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(_timeHM, style: clockTextStyle),
        Text(
          ':$_timeS',
          style: clockTextStyle.copyWith(color: const Color(0xFFB6BABE)),
        ),
      ],
    );
  }
}
