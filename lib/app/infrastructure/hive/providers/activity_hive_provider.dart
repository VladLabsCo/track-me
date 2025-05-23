import 'package:hive_ce/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/infrastructure/hive/hive.dart';

part 'activity_hive_provider.g.dart';

@Riverpod(keepAlive: true)
class ActivityHive extends _$ActivityHive
    with HiveProviderMixin<Activity>
    implements HiveProviderBase<Activity, ActivityCreateDto, Activity> {
  @override
  void build() {}

  @override
  Box<Activity> getBox() => Hive.box<Activity>(activityBox);

  @override
  Future<Activity> create(ActivityCreateDto activityCreateDto) async {
    final newActivity = Activity(
      id: tmUuid(),
      activityTypeId: activityCreateDto.activityTypeId,
      duration: activityCreateDto.duration,
      date: activityCreateDto.date ?? DateTime.now(),
    );

    await getBox().put(newActivity.id, newActivity);

    return newActivity;
  }

  @override
  Future<String> update(Activity activity) async {
    await getBox().put(activity.id, activity);

    return activity.id;
  }
}
