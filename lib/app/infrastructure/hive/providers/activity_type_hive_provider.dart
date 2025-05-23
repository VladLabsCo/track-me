import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/infrastructure/hive/hive.dart';

part 'activity_type_hive_provider.g.dart';

@Riverpod(keepAlive: true)
class ActivityTypeHive extends _$ActivityTypeHive
    with HiveProviderMixin<ActivityType>
    implements
        HiveProviderBase<ActivityType, ActivityTypeCreateDto, ActivityType> {
  @override
  void build() {}

  @override
  Box<ActivityType> getBox() => Hive.box<ActivityType>(activityTypeBox);

  @override
  Future<ActivityType> create(ActivityTypeCreateDto activityCreateDto) async {
    final activity = ActivityType(
      id: tmUuid(),
      name: activityCreateDto.name,
      icon: activityCreateDto.icon,
    );

    await getBox().put(activity.id, activity);

    return activity;
  }

  @override
  Future<String> update(ActivityType activity) async {
    await getBox().put(activity.id, activity);

    return activity.id;
  }
}
