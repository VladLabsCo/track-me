import 'package:hive/hive.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/infrastructure/hive/hive.dart';

part 'activity_stats.g.dart';

@HiveType(typeId: 4)
class ActivityStats extends HiveObject implements HiveBoxDocument {
  ActivityStats({
    required this.id,
    required this.activityTypeId,
    required this.totalDuration,
    this.lastUpdate,
  });

  factory ActivityStats.fromActivityTypeId(String miao) {
    return ActivityStats(
      id: tmUuid(),
      activityTypeId: miao,
      totalDuration: Duration.zero,
      lastUpdate: DateTime.now(),
    );
  }

  ActivityStats copyWithDuration(Duration duration) {
    return ActivityStats(
      id: id,
      activityTypeId: activityTypeId,
      totalDuration: totalDuration + duration,
      lastUpdate: DateTime.now(),
    );
  }

  @override
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String activityTypeId;

  @HiveField(2)
  final Duration totalDuration;

  @HiveField(3)
  final DateTime? lastUpdate;
}

extension ActivityStatsMethods on ActivityStats {}

class ActivityStatsCreateDto {
  const ActivityStatsCreateDto({
    required this.activityTypeId,
  });

  final String activityTypeId;
}
