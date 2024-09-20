import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/infrastructure/infrastucture.dart';

part 'activity_stats_provider.g.dart';

@riverpod
class ActivityStatsNotifier extends _$ActivityStatsNotifier {
  @override
  void build() {}

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
