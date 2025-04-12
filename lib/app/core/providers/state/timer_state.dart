import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:track_me/app/core/core.dart';

part 'timer_state.freezed.dart';
part 'timer_state.g.dart';

@freezed
abstract class TimerState with _$TimerState {
  const factory TimerState({
    required TimerClockState clockState,
    required Duration durationAtPause,
    required DateTime? runDate,
  }) = _TimerState;

  factory TimerState.initial() {
    return const TimerState(
      clockState: TimerClockState.initial,
      durationAtPause: Duration.zero,
      runDate: null,
    );
  }

  factory TimerState.fromJson(Map<String, dynamic> json) =>
      _$TimerStateFromJson(json);
}
