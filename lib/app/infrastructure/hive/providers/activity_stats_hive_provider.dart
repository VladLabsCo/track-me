import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/infrastructure/hive/hive.dart';

part 'activity_stats_hive_provider.g.dart';

@riverpod
class ActivityStatsHive extends _$ActivityStatsHive
    with HiveProviderMixin<ActivityStats>
    implements
        HiveProviderBase<ActivityStats, ActivityStatsCreateDto, ActivityStats> {
  @override
  void build() {}

  @override
  Box<ActivityStats> getBox() => Hive.box<ActivityStats>(activityStatsBox);

  @override
  Future<String> create(ActivityStatsCreateDto activityStatsCreateDto) async {
    final newActivityStats = ActivityStats.fromActivityTypeId(
      activityStatsCreateDto.activityTypeId,
    );

    await getBox().add(newActivityStats);

    return newActivityStats.id;
  }

  @override
  Future<String> update(String id, ActivityStats activityStats) async {
    await getBox().putAt(getIndexFromId(id), activityStats);
    return id;
  }

  ActivityStats findByActivityTypeId(String activityTypeId) {
    final activityStat = getAll().firstWhere(
      (activityStat) => activityStat.activityTypeId == activityTypeId,
    );
    return getBox().getAt(getIndexFromId(activityStat.id))!;
  }
}
