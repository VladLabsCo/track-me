import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/infrastructure/infrastucture.dart';

part 'activity_type_provider.freezed.dart';
part 'activity_type_provider.g.dart';

@freezed
class ActivityTypeState with _$ActivityTypeState {
  const factory ActivityTypeState({
    required List<ActivityType> activityTypes,
    String? activeId,
  }) = _ActivityTypeState;

  factory ActivityTypeState.inital(List<ActivityType> activityTypes) {
    return ActivityTypeState(activityTypes: activityTypes);
  }
}

extension ActivityStateMethods on ActivityTypeState {
  ActivityTypeState setActivityTypes(List<ActivityType> activities) {
    return copyWith(activityTypes: activities);
  }

  ActivityTypeState setActive(String? id) {
    return copyWith(activeId: id);
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

  void setActive(String? id) => state = state.setActive(id);
}
