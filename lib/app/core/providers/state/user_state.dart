import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
sealed class UserState with _$UserState {
  const factory UserState.logged(String name) = LoggedUser;
  const factory UserState.unlogged() = UnloggedUser;
  const factory UserState.unkown() = UnkownUser;
}
