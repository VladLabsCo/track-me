import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/infrastructure/infrastucture.dart';

part 'new_activity_form_provider.freezed.dart';
part 'new_activity_form_provider.g.dart';

@freezed
class NewActivityFormState with _$NewActivityFormState {
  const factory NewActivityFormState({
    required String name,
  }) = _NewActivityFormState;

  factory NewActivityFormState.initial() =>
      const NewActivityFormState(name: '');
}

@riverpod
class ActivityForm extends _$ActivityForm {
  @override
  NewActivityFormState build() => NewActivityFormState.initial();

  void setName(String name) => state = state.copyWith(name: name);

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
