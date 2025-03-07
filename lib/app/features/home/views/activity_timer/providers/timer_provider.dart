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

@Riverpod(keepAlive: true)
class TimerNotifier extends _$TimerNotifier {
  @override
  TimerState build() => TimerState.initial();

  void start() {
    state = state.copyWith(
      clockState: TimerClockState.running,
      runDate: DateTime.now(),
    );
  }

  void pause() {
    final duration =
        DateTime.now().difference(state.runDate!) + state.durationAtPause;

    state = state.copyWith(
      clockState: TimerClockState.paused,
      durationAtPause: Duration(
        days: duration.inDays,
        hours: duration.inHours % 24,
        minutes: duration.inMinutes % 60,
        seconds: duration.inSeconds % 60,
      ),
      runDate: null,
    );
  }

  void resume() {
    state = state.copyWith(
      clockState: TimerClockState.running,
      runDate: DateTime.now(),
    );
  }

  void stop() => state = TimerState.initial();
}
