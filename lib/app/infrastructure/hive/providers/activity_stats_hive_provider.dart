import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/infrastructure/hive/hive.dart';
import 'package:track_me/app/infrastructure/hive/models/activity_stats.dart';

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
    final newActivityStats = ActivityStats(
      id: tmUuid(),
      activityTypeId: activityStatsCreateDto.activityTypeId,
      totalDuration: Duration.zero,
    );

    await getBox().add(newActivityStats);

    return newActivityStats.id;
  }

  @override
  Future<String> update(String id, ActivityStats activityStats) async {
    await getBox().putAt(getIndexFromId(id), activityStats);
    return id;
  }
}
