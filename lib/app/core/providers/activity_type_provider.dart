import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/infrastructure/infrastucture.dart';

part 'activity_type_provider.freezed.dart';
part 'activity_type_provider.g.dart';

@freezed
class ActivityTypeState with _$ActivityTypeState {
  const factory ActivityTypeState({
    required List<ActivityType> types,
    ActivityType? active,
  }) = _ActivityTypeState;

  factory ActivityTypeState.inital(List<ActivityType> types) {
    return ActivityTypeState(types: types);
  }
}

extension ActivityTypeStateMethods on ActivityTypeState {
  ActivityTypeState setActivityTypes(List<ActivityType> types) {
    return copyWith(types: types);
  }

  ActivityTypeState setActive(ActivityType? active) {
    return copyWith(active: active);
  }
}

@Riverpod(keepAlive: true)
class ActivityTypeNotifier extends _$ActivityTypeNotifier {
  @override
  ActivityTypeState build() {
    return ActivityTypeState.inital(
      ref.read(activityTypeHiveProvider.notifier).getAll(),
    );
  }

  void getAll() {
    state = state.setActivityTypes(
      ref.read(activityTypeHiveProvider.notifier).getAll(),
    );
  }

  void setActive(ActivityType? active) => state = state.setActive(active);
}
