import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_me/app/core/core.dart';

part 'user_provider.freezed.dart';
part 'user_provider.g.dart';

const diskNameKey = 'userName';

@freezed
class User with _$User {
  const factory User.logged(String name) = LoggedUser;
  const factory User.unlogged() = UnloggedUser;
  const factory User.unkown() = UnkownUser;
}

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  User build() => const User.unkown();

  Future<SharedPreferences> _getDiskStorage() async {
    return ref.read(diskStorageProvider.future);
  }

  Future<void> init() async {
    final name = (await _getDiskStorage()).getString(diskNameKey) ?? '';

    if (name.isNotEmpty) {
      state = User.logged(name);
    } else {
      state = const User.unlogged();
    }
  }

  Future<void> logIn(String name) async {
    await (await _getDiskStorage()).setString(diskNameKey, name);

    state = User.logged(name);
  }

  Future<String> me() async {
    return (await _getDiskStorage()).getString(diskNameKey)!;
  }
}
