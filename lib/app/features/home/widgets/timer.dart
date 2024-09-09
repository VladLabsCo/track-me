import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/home/providers/timer_provider.dart';

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

class TimerTime extends StatelessWidget {
  const TimerTime({super.key});

  @override
  Widget build(BuildContext context) {
    const clockTextStyle = TextStyle(
      fontSize: 50,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '0:00',
          style: clockTextStyle,
        ),
        Text(
          ':00',
          style: clockTextStyle.copyWith(
            color: const Color(0xFFB6BABE),
          ),
        ),
      ],
    );
  }
}

class TimerControls extends ConsumerWidget {
  const TimerControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clockState = ref.watch(
      timerNotifierProvider.select((timer) => timer.clockState),
    );

    final isRunning = clockState == TimerClockState.running;

    void handlePlayPauseClick() {
      switch (clockState) {
        case TimerClockState.initial:
          ref.read(timerNotifierProvider.notifier).start();
        case TimerClockState.running:
          ref.read(timerNotifierProvider.notifier).pause();
        case TimerClockState.paused:
          ref.read(timerNotifierProvider.notifier).resume();
      }
    }

    Future<void> handleStop() async {
      final hasAgreed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'End activity',
          ),
          content: const Text(
            'Are you sure you are done with it?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Nevermind...',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Yes!',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      );

      if (hasAgreed ?? false) ref.read(timerNotifierProvider.notifier).stop();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (clockState != TimerClockState.initial)
          TmIconButton(
            padding: 15,
            backgroundColor: Theme.of(context).cardColor,
            onPressed: handleStop,
            child: const Icon(
              CupertinoIcons.arrow_counterclockwise,
              size: 20,
              color: Color(0xFFF3F3F3),
            ),
          ),
        const SizedBox(width: 25),
        TmIconButton(
          shadowColor: Theme.of(context).primaryColor,
          onPressed: handlePlayPauseClick,
          child: Transform.translate(
            offset: Offset(isRunning ? 0 : 2.5, 0),
            child: Icon(
              isRunning
                  ? CupertinoIcons.pause_fill
                  : CupertinoIcons.play_arrow_solid,
              size: 28,
              color: const Color(0xFFF3F3F3),
            ),
          ),
        ),
        const SizedBox(width: 25),
        if (clockState != TimerClockState.initial)
          TmIconButton(
            padding: 15,
            backgroundColor: Theme.of(context).cardColor,
            onPressed: handleStop,
            child: const Icon(
              CupertinoIcons.stop_fill,
              size: 20,
              color: Color(0xFFF3F3F3),
            ),
          ),
      ],
    );
  }
}
