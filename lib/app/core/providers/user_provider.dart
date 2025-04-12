import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_me/app/core/providers/state/user_state.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

part 'user_provider.g.dart';

const diskNameKey = 'userName';

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  UserState build() => const UserState.unkown();

  Future<SharedPreferences> _getDiskStorage() async {
    return ref.read(diskStorageProvider.future);
  }

  Future<void> init() async {
    final name = (await _getDiskStorage()).getString(diskNameKey) ?? '';

    if (name.isNotEmpty) {
      state = UserState.logged(name);
    } else {
      state = const UserState.unlogged();
    }
  }

  Future<void> logIn(String name) async {
    await (await _getDiskStorage()).setString(diskNameKey, name);
  }
}
