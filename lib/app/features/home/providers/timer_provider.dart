import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timer_provider.freezed.dart';
part 'timer_provider.g.dart';

enum TimerClockState { initial, running, paused }

@freezed
class TimerState with _$TimerState {
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
}

extension TimerStateMethods on TimerState {
  TimerState start() {
    return copyWith(
      clockState: TimerClockState.running,
      runDate: DateTime.now(),
    );
  }

  TimerState pause(DateTime runDate, Duration prevDurationAtPause) {
    return copyWith(
      clockState: TimerClockState.paused,
      durationAtPause: DateTime.now().difference(runDate) + prevDurationAtPause,
      runDate: null,
    );
  }

  TimerState resume() {
    return copyWith(
      clockState: TimerClockState.running,
      runDate: DateTime.now(),
    );
  }

  TimerState stop() {
    return TimerState.initial();
  }
}

@riverpod
class TimerNotifier extends _$TimerNotifier {
  @override
  TimerState build() => TimerState.initial();

  void start() => state = state.start();

  void pause() => state = state.pause(state.runDate!, state.durationAtPause);

  void resume() => state = state.resume();

  void stop() => state = state.stop();
}
