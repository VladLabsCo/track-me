import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

part 'activity_target_state.freezed.dart';

@freezed
abstract class ActivityTargetState with _$ActivityTargetState {
  const factory ActivityTargetState({
    required List<ActivityTarget> targets,
    required Map<ActivityTarget, ActivityTargetProgress> targetsProgress,
  }) = _ActivityTargetState;
}

class ActivityTargetProgress {
  ActivityTargetProgress({
    required this.isComplete,
    required this.currentDuration,
    required this.currentSessions,
  });

  final bool isComplete;
  final Duration? currentDuration;
  final int? currentSessions;
}
