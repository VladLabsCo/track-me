import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/infrastructure/hive/models/activity.dart';
import 'package:track_me/app/infrastructure/hive/providers/activity_hive_provider.dart';

part 'activity_provider.freezed.dart';
part 'activity_provider.g.dart';

@freezed
class ActivityState with _$ActivityState {
  const factory ActivityState({
    required List<Activity> activities,
  }) = _ActivityState;

  factory ActivityState.inital(List<Activity> activities) {
    return ActivityState(activities: activities);
  }
}

extension ActivityStateMethods on ActivityState {
  ActivityState setActivities(List<Activity> activities) {
    return copyWith(activities: activities);
  }
}

@riverpod
class ActivityNotifier extends _$ActivityNotifier {
  @override
  ActivityState build() {
    return ActivityState.inital(
      ref.read(activityHiveProvider.notifier).getAll(),
    );
  }
}
