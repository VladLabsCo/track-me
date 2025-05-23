import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/infrastructure/hive/hive.dart';

part 'activity_stats.freezed.dart';
part 'activity_stats.g.dart';

@freezed
@HiveType(typeId: 1)
abstract class ActivityStats extends HiveObject
    with _$ActivityStats
    implements HiveBoxDocument {
  factory ActivityStats({
    @override @HiveField(0) required String id,
    @HiveField(1) required String activityTypeId,
    @HiveField(2) required Duration totalDuration,
    @HiveField(3) DateTime? lastUpdate,
  }) = _ActivityStats;

  ActivityStats._();

  factory ActivityStats.fromActivityTypeId(String activityTypeId) {
    return ActivityStats(
      id: tmUuid(),
      activityTypeId: activityTypeId,
      totalDuration: Duration.zero,
    );
  }
}

class ActivityStatsCreateDto {
  const ActivityStatsCreateDto({
    required this.activityTypeId,
  });

  final String activityTypeId;
}
