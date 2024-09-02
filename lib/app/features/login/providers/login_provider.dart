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
}

extension LoginStateMethods on LoginState {
  LoginState setName(String newName) {
    return copyWith(name: newName);
  }
}

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  LoginState build() => const LoginState(name: '');

  void setName(String newName) {
    state = state.setName(newName);
  }

  Future<void> logIn() async {
    return ref.read(userNotifierProvider.notifier).logIn(state.name);
  }
}
