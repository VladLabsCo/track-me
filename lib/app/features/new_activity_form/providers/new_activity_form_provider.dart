import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/new_activity_form/providers/state/new_activity_form_state.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

part 'new_activity_form_provider.g.dart';

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

    ref.read(activityTypeProvider.notifier)
      ..getAll()
      ..setActive(activityType);

    return true;
  }
}
