import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/infrastructure/hive/hive.dart';

part 'activity_hive_provider.g.dart';

@riverpod
class ActivityHive extends _$ActivityHive
    with HiveProviderMixin<Activity>
    implements HiveProviderBase<Activity, ActivityCreateDto, Activity> {
  @override
  void build() {}

  @override
  Box<Activity> getBox() => Hive.box<Activity>(activityBox);

  @override
  Future<String> create(ActivityCreateDto activityCreateDto) async {
    final newActivity = Activity(
      id: tmUuid(),
      activityTypeId: activityCreateDto.activityTypeId,
      duration: activityCreateDto.duration,
      date: DateTime.now(),
    );

    await getBox().add(newActivity);

    return newActivity.id;
  }

  @override
  Future<String> update(String id, Activity activity) async {
    await getBox().putAt(getIndexFromId(id), activity);
    return id;
  }
}
