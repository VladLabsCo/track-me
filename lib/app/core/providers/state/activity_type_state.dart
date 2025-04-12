import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

part 'activity_type_state.freezed.dart';

@freezed
abstract class ActivityTypeState with _$ActivityTypeState {
  const factory ActivityTypeState({
    required List<ActivityType> types,
    ActivityType? active,
  }) = _ActivityTypeState;

  factory ActivityTypeState.inital(List<ActivityType> types) {
    return ActivityTypeState(types: types);
  }
}
