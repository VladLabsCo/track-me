import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/infrastructure/hive/hive.dart';

part 'activity_stats_hive_provider.g.dart';

@Riverpod(keepAlive: true)
class ActivityStatsHive extends _$ActivityStatsHive
    with HiveProviderMixin<ActivityStats>
    implements
        HiveProviderBase<ActivityStats, ActivityStatsCreateDto, ActivityStats> {
  @override
  void build() {}

  @override
  Box<ActivityStats> getBox() => Hive.box<ActivityStats>(activityStatsBox);

  @override
  Future<ActivityStats> create(
    ActivityStatsCreateDto activityStatsCreateDto,
  ) async {
    final newActivityStats = ActivityStats.fromActivityTypeId(
      activityStatsCreateDto.activityTypeId,
    );

    await getBox().put(newActivityStats.id, newActivityStats);

    return newActivityStats;
  }

  @override
  Future<String> update(ActivityStats activityStats) async {
    await getBox().put(activityStats.id, activityStats);

    return activityStats.id;
  }

  ActivityStats? findByActivityTypeId(String activityTypeId) {
    final activityStat = getAll().firstWhere(
      (activityStat) => activityStat.activityTypeId == activityTypeId,
    );

    return getBox().get(activityStat.id);
  }
}
