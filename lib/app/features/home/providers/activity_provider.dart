import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/infrastructure/infrastucture.dart';

part 'activity_provider.freezed.dart';
part 'activity_provider.g.dart';

@freezed
class ActivityState with _$ActivityState {
  const factory ActivityState({
    required List<Activity> activities,
    String? activeId,
  }) = _ActivityState;

  factory ActivityState.inital(List<Activity> activities) {
    return ActivityState(activities: activities);
  }
}

extension ActivityStateMethods on ActivityState {
  ActivityState setActivities(List<Activity> activities) {
    return copyWith(activities: activities);
  }

  ActivityState setActive(String? id) {
    return copyWith(activeId: id);
  }
}

@Riverpod(keepAlive: true)
class ActivityNotifier extends _$ActivityNotifier {
  @override
  ActivityState build() {
    return ActivityState.inital(
      ref.read(activityHiveProvider.notifier).getAll(),
    );
  }

  void getAll() {
    state = state.setActivities(
      ref.read(activityHiveProvider.notifier).getAll(),
    );
  }

  void setActive(String? id) => state = state.setActive(id);
}
