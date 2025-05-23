import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:track_me/app/infrastructure/hive/hive.dart';

part 'activity_type.freezed.dart';
part 'activity_type.g.dart';

@freezed
@HiveType(typeId: 0)
abstract class ActivityType extends HiveObject
    with _$ActivityType
    implements HiveBoxDocument {
  factory ActivityType({
    @override @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) @Default(false) bool isArchived,
    @HiveField(3) String? icon,
    @HiveField(4) String? categoryId,
  }) = _ActivityType;

  ActivityType._();
}

class ActivityTypeCreateDto {
  const ActivityTypeCreateDto({
    required this.name,
    this.icon,
    this.category,
  });

  final String name;
  final String? icon;
  final String? category;
}
