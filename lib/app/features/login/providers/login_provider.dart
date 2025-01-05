import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/core.dart';

part 'login_provider.freezed.dart';
part 'login_provider.g.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required String name,
  }) = _LoginState;

  factory LoginState.initial() => const LoginState(name: '');
}

extension LoginStateMethods on LoginState {
  LoginState setName(String name) {
    return copyWith(name: name);
  }
}

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  LoginState build() => LoginState.initial();

  void setName(String name) => state = state.setName(name);

  Future<void> logIn() async {
    return ref.read(userNotifierProvider.notifier).logIn(state.name);
  }
}
