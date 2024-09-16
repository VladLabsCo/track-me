import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/features/home/providers/activity_provider.dart';
import 'package:track_me/app/infrastructure/hive/models/activity_stats.dart';
import 'package:track_me/app/infrastructure/hive/providers/activity_stats_hive_provider.dart';
import 'package:track_me/app/infrastructure/infrastucture.dart';

part 'activity_form_provider.freezed.dart';
part 'activity_form_provider.g.dart';

@freezed
class ActivityFormState with _$ActivityFormState {
  const factory ActivityFormState({
    required String name,
  }) = _ActivityFormState;

  factory ActivityFormState.initial() => const ActivityFormState(name: '');
}

extension ActivityFormStateMethods on ActivityFormState {
  ActivityFormState setName(String name) {
    return copyWith(name: name);
  }
}

@riverpod
class ActivityForm extends _$ActivityForm {
  @override
  ActivityFormState build() => ActivityFormState.initial();

  void setName(String name) => state = state.setName(name);

  Future<bool> submit() async {
    if (state.name.isEmpty) return false;

    final activityId = await ref
        .read(activityHiveProvider.notifier)
        .create(ActivityCreateDto(name: state.name));

    await ref
        .read(activityStatsHiveProvider.notifier)
        .create(ActivityStatsCreateDto(activityId: activityId));

    ref.read(activityNotifierProvider.notifier)
      ..getAll()
      ..setActive(activityId);

    return true;
  }
}
