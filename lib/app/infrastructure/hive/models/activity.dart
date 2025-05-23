import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

@freezed
@HiveType(typeId: 2)
abstract class Activity extends HiveObject
    with _$Activity
    implements HiveBoxDocument {
  factory Activity({
    @override @HiveField(0) required String id,
    @HiveField(1) required String activityTypeId,
    @HiveField(2) required Duration duration,
    @HiveField(3) required DateTime date,
  }) = _Activity;

  Activity._();
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
