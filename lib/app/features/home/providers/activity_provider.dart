import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity_provider.freezed.dart';
part 'activity_provider.g.dart';

@freezed
class ActivityState with _$ActivityState {
  const factory ActivityState({int? activeIndex}) = _ActivityState;

  factory ActivityState.inital() {
    return const ActivityState();
  }
}

extension ActivityStateMethods on ActivityState {
  ActivityState setActive(int activity) {
    return ActivityState(activeIndex: activity);
  }
}

@Riverpod(keepAlive: true)
class ActivityNotifier extends _$ActivityNotifier {
  @override
  ActivityState build() => ActivityState.inital();

  void setActive(int activity) => state = state.setActive(activity);
}
