import 'package:hive_ce/hive.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

part 'activity.g.dart';

@HiveType(typeId: 2)
class Activity extends HiveObject implements HiveBoxDocument {
  Activity({
    required this.id,
    required this.activityTypeId,
    required this.duration,
    required this.date,
  });

  @override
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String activityTypeId;

  @HiveField(2)
  final Duration duration;

  @HiveField(3)
  final DateTime date;
}

class ActivityCreateDto {
  const ActivityCreateDto({
    required this.activityTypeId,
    required this.duration,
    this.date,
  });

  final String activityTypeId;
  final Duration duration;
  final DateTime? date;
}
