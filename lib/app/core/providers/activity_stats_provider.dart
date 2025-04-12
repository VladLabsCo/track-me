import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/providers/state/activity_stats_state.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

part 'activity_stats_provider.g.dart';

@riverpod
class ActivityStatsNotifier extends _$ActivityStatsNotifier {
  @override
  ActivityStatsState build() {
    final stats = ref.read(activityStatsHiveProvider.notifier).getAll()
      ..sort((a, b) {
        if (a.lastUpdate == null && b.lastUpdate == null) {
          return 0;
        }
        if (a.lastUpdate == null) {
          return 1;
        }
        if (b.lastUpdate == null) {
          return -1;
        }
        return b.lastUpdate!.compareTo(a.lastUpdate!);
      });

    return ActivityStatsState.inital(
      stats,
    );
  }

  Future<void> registerTimer(String activityTypeId, Duration duration) async {
    final activityStat = ref
        .read(activityStatsHiveProvider.notifier)
        .findByActivityTypeId(activityTypeId);

    final updatedActivityState = activityStat.copyWithDuration(duration);

    await ref
        .read(activityStatsHiveProvider.notifier)
        .update(activityStat.id, updatedActivityState);

    return;
  }
}
