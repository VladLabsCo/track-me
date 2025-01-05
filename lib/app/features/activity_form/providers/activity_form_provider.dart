import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/core.dart';
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

    final activityType = await ref
        .read(activityTypeHiveProvider.notifier)
        .create(ActivityTypeCreateDto(name: state.name));

    await ref
        .read(activityStatsHiveProvider.notifier)
        .create(ActivityStatsCreateDto(activityTypeId: activityType.id));

    ref.read(activityTypeNotifierProvider.notifier)
      ..getAll()
      ..setActive(activityType);

    return true;
  }
}
