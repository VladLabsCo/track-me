import 'package:freezed_annotation/freezed_annotation.dart';

part 'manual_activity_form_state.freezed.dart';

@freezed
abstract class ManualActivityFormState with _$ManualActivityFormState {
  const factory ManualActivityFormState({
    required DateTime date,
    required Duration duration,
  }) = _ManualActivityFormState;

  factory ManualActivityFormState.initial() => ManualActivityFormState(
        date: DateTime.now(),
        duration: Duration.zero,
      );
}
