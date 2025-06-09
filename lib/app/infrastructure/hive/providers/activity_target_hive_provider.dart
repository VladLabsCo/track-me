import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

part 'activity_target_hive_provider.g.dart';

@Riverpod(keepAlive: true)
class ActivityTargetHive extends _$ActivityTargetHive
    with
        HiveProviderMixin<ActivityTarget>
    implements
        HiveProviderBase<ActivityTarget, ActivityTargetCreateDto,
            ActivityTarget> {
  @override
  void build() {}

  @override
  Box<ActivityTarget> getBox() => Hive.box<ActivityTarget>(activityTargetBox);

  @override
  Future<ActivityTarget> create(
    ActivityTargetCreateDto activityTargetCreateDto,
  ) async {
    final newActivityTarget = ActivityTarget(
      id: tmUuid(),
      activityTypeId: activityTargetCreateDto.activityTypeId,
      targetDuration: activityTargetCreateDto.targetDuration,
      targetSessions: activityTargetCreateDto.targetSessions,
    );

    await getBox().put(newActivityTarget.id, newActivityTarget);

    return newActivityTarget;
  }

  @override
  Future<String> update(ActivityTarget activityTarget) async {
    await getBox().put(activityTarget.id, activityTarget);

    return activityTarget.id;
  }
}
