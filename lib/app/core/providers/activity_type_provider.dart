import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/providers/state/activity_type_state.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

part 'activity_type_provider.g.dart';

const diskActivityTypeKey = 'activityType';

@Riverpod(keepAlive: true)
class ActivityTypeNotifier extends _$ActivityTypeNotifier {
  @override
  ActivityTypeState build() {
    final activityTypes = ref.read(activityTypeHiveProvider.notifier).getAll();
    maybeResumeFromDisk(activityTypes: activityTypes);

    return ActivityTypeState.inital(
      activityTypes,
    );
  }

  Future<void> _updateDiskValue(ActivityType? activityType) async {
    final diskStorage = await ref.read(diskStorageProvider.future);

    await diskStorage.setString(
      diskActivityTypeKey,
      activityType != null ? activityType.id : '',
    );
  }

  Future<void> maybeResumeFromDisk({List<ActivityType>? activityTypes}) async {
    final diskStorage = await ref.read(diskStorageProvider.future);

    final diskActivityTypeId = diskStorage.getString(diskActivityTypeKey);
    if (diskActivityTypeId == null || diskActivityTypeId == state.active?.id) {
      return;
    }

    final diskActivityType = (activityTypes ?? state.types).firstWhere(
      (activityType) => activityType.id == diskActivityTypeId,
      orElse: () => ActivityType(id: '', name: ''),
    );
    if (diskActivityType.id.isEmpty) return;

    state = state.copyWith(active: diskActivityType);
  }

  void getAll() {
    state = state.copyWith(
      types: ref.read(activityTypeHiveProvider.notifier).getAll(),
    );
  }

  void setActive(ActivityType? activityType) {
    state = state.copyWith(active: activityType);
  }

  void storeCurrentType() {
    _updateDiskValue(state.active);
  }

  void clearStoredType() {
    _updateDiskValue(null);
  }
}
