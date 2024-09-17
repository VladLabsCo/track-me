import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/home/providers/activity_provider.dart';
import 'package:track_me/app/features/home/providers/timer_provider.dart';

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
      await tmDialogConfirm(
        context: context,
        title: 'End activity',
        subtitle: 'Are you sure you are done with it?',
        deny: 'Nevermind...',
        accept: 'Yes!',
        onAccepted: () {
          ref.read(timerNotifierProvider.notifier).stop();
          ref.read(activityTypeNotifierProvider.notifier).setActive(null);
        },
      );
    }

    Future<void> handleCancel() async {
      await tmDialogConfirm(
        context: context,
        title: 'Cancel activity',
        subtitle: 'Are you sure you want to discard your progress?',
        deny: 'Oops, go back',
        accept: 'Yes, cancel it!',
        onAccepted: ref.read(timerNotifierProvider.notifier).stop,
      );
    }

    final isClockRunning = clockState != TimerClockState.initial;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TmIconButton(
          disabled: !isClockRunning,
          disabledOpacity: 0,
          padding: 15,
          backgroundColor: Theme.of(context).cardColor,
          onPressed: handleCancel,
          child: const Icon(
            CupertinoIcons.arrow_counterclockwise,
            size: 20,
            color: Color(0xFFF3F3F3),
          ),
        ),
        const SizedBox(width: 25),
        TmIconButton(
          disabled: ref.watch(activityTypeNotifierProvider).activeId == null,
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
        TmIconButton(
          disabled: !isClockRunning,
          disabledOpacity: 0,
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
