import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/infrastructure/infrastucture.dart';

part 'activity_stats_provider.freezed.dart';
part 'activity_stats_provider.g.dart';

@freezed
class ActivityStatsState with _$ActivityStatsState {
  const factory ActivityStatsState({
    required List<ActivityStats> stats,
  }) = _ActivityStatsState;

  factory ActivityStatsState.inital(List<ActivityStats> stats) {
    return ActivityStatsState(stats: stats);
  }
}

extension ActivityStatsStateMethods on ActivityStatsState {
  ActivityStatsState setStats(List<ActivityStats> stats) {
    return copyWith(stats: stats);
  }
}

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
