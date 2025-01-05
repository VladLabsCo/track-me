import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/home/views/activity_timer/providers/timer_provider.dart';
import 'package:track_me/app/infrastructure/infrastucture.dart';

class TimerControls extends ConsumerWidget {
  const TimerControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clockState = ref.watch(
      timerNotifierProvider.select((timer) => timer.clockState),
    );

    final isRunning = clockState == TimerClockState.running;

    void createNotification() {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'ongoing_channel',
          title: 'Ongoing Activity',
          body: ref.read(activityTypeNotifierProvider).active!.name,
          category: NotificationCategory.Reminder,
          autoDismissible: false,
          locked: true,
        ),
      );
    }

    Future<void> cancelNotification() async {
      await AwesomeNotifications().cancel(1);
    }

    void handlePlayPauseClick() {
      switch (clockState) {
        case TimerClockState.initial:
          ref.read(timerNotifierProvider.notifier).start();
          createNotification();
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
        onAccepted: () async {
          final timerState = ref.read(timerNotifierProvider);
          final activeType = ref.read(activityTypeNotifierProvider).active;

          ref.read(timerNotifierProvider.notifier).stop();
          ref.read(activityTypeNotifierProvider.notifier).setActive(null);

          late Duration totalDuration;

          if (timerState.clockState == TimerClockState.running) {
            final totalDurationFull =
                DateTime.now().difference(timerState.runDate!) +
                    timerState.durationAtPause;
            totalDuration = Duration(
              days: totalDurationFull.inDays,
              hours: totalDurationFull.inHours % 24,
              minutes: totalDurationFull.inMinutes % 60,
              seconds: totalDurationFull.inSeconds % 60,
            );
          } else {
            totalDuration = timerState.durationAtPause;
          }

          await ref.read(activityHiveProvider.notifier).create(
                ActivityCreateDto(
                  activityTypeId: activeType!.id,
                  duration: totalDuration,
                ),
              );

          await ref
              .read(activityStatsNotifierProvider.notifier)
              .registerTimer(activeType.id, totalDuration);

          ref.invalidate(activityNotifierProvider);

          await cancelNotification();
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
        onAccepted: () async {
          ref.read(timerNotifierProvider.notifier).stop();
          await cancelNotification();
        },
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
          disabled: ref.watch(activityTypeNotifierProvider).active == null,
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
