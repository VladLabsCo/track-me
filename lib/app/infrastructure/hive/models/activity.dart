import 'package:hive/hive.dart';

part 'activity.g.dart';

@HiveType(typeId: 1)
class Activity extends HiveObject {
  Activity({
    required this.id,
    required this.name,
    this.icon,
    this.category,
  });

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
