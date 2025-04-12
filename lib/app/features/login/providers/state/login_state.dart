import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    required String name,
  }) = _LoginState;

  factory LoginState.initial() => const LoginState(name: '');
}
