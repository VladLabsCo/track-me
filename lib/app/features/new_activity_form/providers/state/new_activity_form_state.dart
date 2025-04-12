import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_activity_form_state.freezed.dart';

@freezed
abstract class NewActivityFormState with _$NewActivityFormState {
  const factory NewActivityFormState({
    required String name,
  }) = _NewActivityFormState;

  factory NewActivityFormState.initial() =>
      const NewActivityFormState(name: '');
}
