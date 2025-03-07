import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/infrastructure/infrastucture.dart';

part 'activity_type_provider.freezed.dart';
part 'activity_type_provider.g.dart';

const diskActivityTypeKey = 'activityType';

@freezed
class ActivityTypeState with _$ActivityTypeState {
  const factory ActivityTypeState({
    required List<ActivityType> types,
    ActivityType? active,
  }) = _ActivityTypeState;

  factory ActivityTypeState.inital(List<ActivityType> types) {
    return ActivityTypeState(types: types);
  }
}

@Riverpod(keepAlive: true)
class ActivityTypeNotifier extends _$ActivityTypeNotifier {
  @override
  ActivityTypeState build() {
    final activityTypes = ref.read(activityTypeHiveProvider.notifier).getAll();
    _maybeResumeFromDisk(activityTypes);

    return ActivityTypeState.inital(
      activityTypes,
    );
  }

  Future<void> _maybeResumeFromDisk(List<ActivityType> activityTypes) async {
    final diskStorage = await ref.read(diskStorageProvider.future);

    final diskActivityTypeId = diskStorage.getString(diskActivityTypeKey);
    if (diskActivityTypeId == null) return;

    final activityType = activityTypes.firstWhere(
      (activityType) => activityType.id == diskActivityTypeId,
    );

    state = state.copyWith(active: activityType);
  }

  Future<void> _updateDiskValue(ActivityType? activityType) async {
    final diskStorage = await ref.read(diskStorageProvider.future);

    await diskStorage.setString(
      diskActivityTypeKey,
      activityType != null ? activityType.id : '',
    );
  }

  void getAll() {
    state = state.copyWith(
      types: ref.read(activityTypeHiveProvider.notifier).getAll(),
    );
  }

  void setActive(ActivityType? activityType) {
    state = state.copyWith(active: activityType);
    _updateDiskValue(activityType);
  }
}
