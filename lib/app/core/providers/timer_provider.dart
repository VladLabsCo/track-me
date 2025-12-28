import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

part 'timer_provider.g.dart';

const diskTimerKey = 'timer';

@Riverpod(keepAlive: true)
class TimerNotifier extends _$TimerNotifier {
  @override
  TimerState build() {
    maybeResumeFromDisk();
    return TimerState.initial();
  }

  Future<void> _updateDiskValue(TimerState? state) async {
    final diskStorage = await ref.read(diskStorageProvider.future);

    await diskStorage.setString(
      diskTimerKey,
      state != null ? jsonEncode(state.toJson()) : '',
    );
  }

  Future<void> maybeResumeFromDisk() async {
    final diskStorage = await ref.read(diskStorageProvider.future);

    final diskJsonString = diskStorage.getString(diskTimerKey);
    if (diskJsonString == null || diskJsonString.isEmpty) return;

    final diskState = TimerState.fromJson(
      jsonDecode(diskJsonString) as Map<String, dynamic>,
    );
    if (state.clockState == diskState.clockState &&
        state.runDate == diskState.runDate &&
        state.durationAtPause == diskState.durationAtPause) {
      return;
    }

    state = diskState;
  }

  void start() {
    final newState = state.copyWith(
      clockState: TimerClockState.running,
      runDate: DateTime.now(),
    );

    state = newState;
    _updateDiskValue(newState);
    ref.read(activityTypeProvider.notifier).storeCurrentType();
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
    ref.read(activityTypeProvider.notifier).clearStoredType();
  }
}
