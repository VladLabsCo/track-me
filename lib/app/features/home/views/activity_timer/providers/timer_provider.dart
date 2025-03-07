import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/core.dart';

part 'timer_provider.freezed.dart';
part 'timer_provider.g.dart';

const diskTimerKey = 'timer';

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

  factory TimerState.fromJson(Map<String, dynamic> json) =>
      _$TimerStateFromJson(json);
}

@Riverpod(keepAlive: true)
class TimerNotifier extends _$TimerNotifier {
  @override
  TimerState build() {
    _maybeResumeFromDisk();
    return TimerState.initial();
  }

  Future<void> _maybeResumeFromDisk() async {
    final diskStorage = await ref.read(diskStorageProvider.future);

    final diskJsonString = diskStorage.getString(diskTimerKey);
    if (diskJsonString == null || diskJsonString.isEmpty) return;

    state = TimerState.fromJson(
      jsonDecode(diskJsonString) as Map<String, dynamic>,
    );
  }

  Future<void> _updateDiskValue(TimerState? state) async {
    final diskStorage = await ref.read(diskStorageProvider.future);

    await diskStorage.setString(
      diskTimerKey,
      state != null ? jsonEncode(state.toJson()) : '',
    );
  }

  void start() {
    final newState = state.copyWith(
      clockState: TimerClockState.running,
      runDate: DateTime.now(),
    );

    state = newState;
    _updateDiskValue(newState);
  }

  void pause() {
    final duration =
        DateTime.now().difference(state.runDate!) + state.durationAtPause;

    final newState = state.copyWith(
      clockState: TimerClockState.paused,
      durationAtPause: Duration(
        days: duration.inDays,
        hours: duration.inHours % 24,
        minutes: duration.inMinutes % 60,
        seconds: duration.inSeconds % 60,
      ),
      runDate: null,
    );

    state = newState;
    _updateDiskValue(newState);
  }

  void resume() {
    final newState = state.copyWith(
      clockState: TimerClockState.running,
      runDate: DateTime.now(),
    );

    state = newState;
    _updateDiskValue(newState);
  }

  void stop() {
    state = TimerState.initial();
    _updateDiskValue(null);
  }
}
