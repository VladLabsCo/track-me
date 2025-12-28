import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

part 'activity_target_form_state.freezed.dart';

@freezed
abstract class ActivityTargetFormState with _$ActivityTargetFormState {
  const factory ActivityTargetFormState({
    required ActivityType? activityType,
  }) = _ActivityTargetFormState;

  factory ActivityTargetFormState.initial() => const ActivityTargetFormState(
        activityType: null,
      );
}
