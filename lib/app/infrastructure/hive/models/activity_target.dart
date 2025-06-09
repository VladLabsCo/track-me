import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

part 'activity_target.freezed.dart';
part 'activity_target.g.dart';

@freezed
@HiveType(typeId: 3)
abstract class ActivityTarget extends HiveObject
    with _$ActivityTarget
    implements HiveBoxDocument {
  factory ActivityTarget({
    @override @HiveField(0) required String id,
    @HiveField(1) required String activityTypeId,
    @HiveField(2) Duration? targetDuration,
    @HiveField(3) int? targetSessions,
  }) = _ActivityTarget;

  ActivityTarget._();
}

class ActivityTargetCreateDto {
  ActivityTargetCreateDto({
    required this.activityTypeId,
    this.targetDuration,
    this.targetSessions,
  });

  final String activityTypeId;
  final Duration? targetDuration;
  final int? targetSessions;
}
