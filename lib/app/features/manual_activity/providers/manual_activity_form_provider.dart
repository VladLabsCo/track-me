import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/manual_activity/providers/state/manual_activity_form_state.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

part 'manual_activity_form_provider.g.dart';

@riverpod
class ManualActivityFormNotifier extends _$ManualActivityFormNotifier {
  @override
  ManualActivityFormState build() => ManualActivityFormState.initial();

  void setType(ActivityType type) => state = state.copyWith(activityType: type);

  void setDate(DateTime value) => state = state.copyWith(date: value);

  void setDuration(Duration value) => state = state.copyWith(duration: value);

  Future<void> save() async {
    await ref
        .read(activityStatsNotifierProvider.notifier)
        .registerTimer(state.activityType!.id, state.duration);

    await ref.read(activityHiveProvider.notifier).create(
          ActivityCreateDto(
            activityTypeId: state.activityType!.id,
            duration: state.duration,
            date: state.date,
          ),
        );

    ref
      ..invalidate(activityStatsNotifierProvider)
      ..invalidate(activityNotifierProvider);
  }
}
