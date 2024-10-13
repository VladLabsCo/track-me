import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/features/home/views/activity_timer/providers/timer_provider.dart';

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
  void initState() {
    // Resume normal behaviour when navigating back to screen
    if (widget.timerState.clockState != TimerClockState.initial) {
      _getSetTime(
        widget.timerState.runDate,
        widget.timerState.durationAtPause,
      );

      if (widget.timerState.clockState == TimerClockState.running) {
        _startTimer(
          widget.timerState.runDate!,
          widget.timerState.durationAtPause,
        );
      }
    }

    super.initState();
  }

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

  @override
  void dispose() {
    if (_timer != null) _timer!.cancel();
    super.dispose();
  }

  void _resetTimer(bool wasRunning) {
    if (wasRunning) _timer!.cancel();

    if (mounted) {
      setState(() {
        _timeHM = '0:00';
        _timeS = '00';
        if (wasRunning) _timer = null;
      });
    }
  }

  void _startTimer(DateTime runDate, Duration durationAtPause) {
    if (mounted) {
      setState(() {
        _timer ??= Timer.periodic(
          const Duration(seconds: 1),
          (_) => _getSetTime(runDate, durationAtPause),
        );
      });
    }
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();

      if (mounted) {
        setState(() {
          _timer = null;
        });
      }
    }
  }

  void _getSetTime(DateTime? runDate, Duration durationAtPause) {
    final now = DateTime.now();

    final totalDuration = runDate != null
        ? now.difference(runDate) + durationAtPause
        : durationAtPause;

    final hours = totalDuration.inHours.toString();
    final minutes = (totalDuration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (totalDuration.inSeconds % 60).toString().padLeft(2, '0');

    if (mounted) {
      setState(() {
        _timeHM = '$hours:$minutes';
        _timeS = seconds;
      });
    }
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
