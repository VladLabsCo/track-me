import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

part 'activity_state.freezed.dart';

@freezed
abstract class ActivityState with _$ActivityState {
  const factory ActivityState({
    required List<Activity> activities,
  }) = _ActivityState;

  factory ActivityState.inital(List<Activity> activities) {
    return ActivityState(activities: activities);
  }
}
