import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

part 'manual_activity_form_state.freezed.dart';

@freezed
abstract class ManualActivityFormState with _$ManualActivityFormState {
  const factory ManualActivityFormState({
    required ActivityType? activityType,
    required DateTime date,
    required Duration duration,
  }) = _ManualActivityFormState;

  factory ManualActivityFormState.initial() => ManualActivityFormState(
        activityType: null,
        date: DateTime.now(),
        duration: Duration.zero,
      );
}
