import 'package:hive/hive.dart';
import 'package:track_me/app/infrastructure/hive/hive.dart';

part 'activity_stats.g.dart';

@HiveType(typeId: 4)
class ActivityStats extends HiveObject implements HiveBoxDocument {
  ActivityStats({
    required this.id,
    required this.activityTypeId,
    required this.totalDuration,
  });

  ActivityStats copyWithDuration(Duration duration) {
    return ActivityStats(
      id: id,
      activityTypeId: activityTypeId,
      totalDuration: totalDuration + duration,
    );
  }

  @override
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String activityTypeId;

  @HiveField(2)
  final Duration totalDuration;
}

extension ActivityStatsMethods on ActivityStats {}

class ActivityStatsCreateDto {
  const ActivityStatsCreateDto({
    required this.activityTypeId,
  });

  final String activityTypeId;
}
