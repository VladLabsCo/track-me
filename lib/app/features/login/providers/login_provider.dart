import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/login/providers/state/login_state.dart';

part 'login_provider.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  LoginState build() => LoginState.initial();

  void setName(String name) => state = state.copyWith(name: name);

  Future<void> logIn() async {
    return ref.read(userNotifierProvider.notifier).logIn(state.name);
  }
}
