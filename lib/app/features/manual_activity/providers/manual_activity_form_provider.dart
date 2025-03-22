import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/infrastructure/hive/models/activity.dart';
import 'package:track_me/app/infrastructure/hive/providers/activity_hive_provider.dart';

part 'manual_activity_form_provider.freezed.dart';
part 'manual_activity_form_provider.g.dart';

@freezed
abstract class ManualActivityFormState with _$ManualActivityFormState {
  const factory ManualActivityFormState({
    required DateTime date,
    required Duration duration,
  }) = _ManualActivityFormState;

  factory ManualActivityFormState.initial() => ManualActivityFormState(
        date: DateTime.now(),
        duration: Duration.zero,
      );
}

@riverpod
class ManualActivityFormNotifier extends _$ManualActivityFormNotifier {
  @override
  ManualActivityFormState build() => ManualActivityFormState.initial();

  void setDate(DateTime value) => state = state.copyWith(date: value);

  void setDuration(Duration value) => state = state.copyWith(duration: value);

  Future<void> save() async {
    final activityType = ref.read(activityTypeNotifierProvider).active;

    await ref
        .read(activityStatsNotifierProvider.notifier)
        .registerTimer(activityType!.id, state.duration);

    await ref.read(activityHiveProvider.notifier).create(
          ActivityCreateDto(
            activityTypeId: activityType.id,
            duration: state.duration,
            date: state.date,
          ),
        );

    ref.invalidate(activityStatsNotifierProvider);
    ref.invalidate(activityNotifierProvider);
  }
}
