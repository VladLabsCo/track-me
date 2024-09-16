import 'package:hive/hive.dart';
import 'package:track_me/app/infrastructure/hive/hive.dart';

part 'activity.g.dart';

@HiveType(typeId: 1)
class Activity extends HiveObject implements HiveBoxDocument {
  Activity({
    required this.id,
    required this.name,
    this.icon,
    this.category,
  });

  @override
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? icon;

  @HiveField(3)
  final String? category;
}

class ActivityCreateDto {
  const ActivityCreateDto({
    required this.name,
    this.icon,
    this.category,
  });

  final String name;
  final String? icon;
  final String? category;
}
