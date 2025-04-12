import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/infrastructure/hive/hive.dart';

part 'activity_type_hive_provider.g.dart';

@riverpod
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
      category: activityCreateDto.category,
    );

    await getBox().add(activity);

    return activity;
  }

  @override
  Future<String> update(String id, ActivityType activity) async {
    await getBox().putAt(getIndexFromId(id), activity);
    return id;
  }
}
