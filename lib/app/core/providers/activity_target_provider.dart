import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/core/providers/state/activity_target_state.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

part 'activity_target_provider.g.dart';

@Riverpod(keepAlive: true)
class ActivityTargetNotifier extends _$ActivityTargetNotifier {
  @override
  ActivityTargetState build() {
    final activityTargets =
        ref.read(activityTargetHiveProvider.notifier).getAll();

    _calculateCurrentWeekTargets(activityTargets);

    return ActivityTargetState(
      targets: activityTargets,
      targetsProgress: {},
    );
  }

  Future<void> _calculateCurrentWeekTargets(
      List<ActivityTarget> activityTargets) async {
    final activities = ref.read(activityNotifierProvider).activities;

    final targetsProgress = <ActivityTarget, ActivityTargetProgress>{};

    for (final activityTarget in activityTargets) {
      var totalDuration = Duration.zero;
      var totalSessions = 0;

      for (final activity in activities) {
        // TODO: check if activities are read from most recent to oldest
        if (activity.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        )) {
          break;
        }

        totalDuration += activity.duration;
        totalSessions += 1;
      }

      final activityTargetProgress = ActivityTargetProgress(
        isComplete: false,
        currentDuration: totalDuration,
        currentSessions: totalSessions,
      );

      targetsProgress[activityTarget] = activityTargetProgress;
    }

    state = state.copyWith(targetsProgress: targetsProgress);
  }

  Future<void> recalculateTargets() async {
    await _calculateCurrentWeekTargets(
      ref.read(activityTargetHiveProvider.notifier).getAll(),
    );
  }
}
