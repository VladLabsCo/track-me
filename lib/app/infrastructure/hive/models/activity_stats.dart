import 'package:hive/hive.dart';
import 'package:track_me/app/infrastructure/hive/hive.dart';

part 'activity_stats.g.dart';

@HiveType(typeId: 2)
class ActivityStats extends HiveObject implements HiveBoxDocument {
  ActivityStats({
    required this.id,
    required this.activityTypeId,
    required this.totalDuration,
  });

  @override
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String activityTypeId;

  @HiveField(2)
  final Duration totalDuration;
}

class ActivityStatsCreateDto {
  const ActivityStatsCreateDto({
    required this.activityTypeId,
  });

  final String activityTypeId;
}
