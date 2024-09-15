import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/infrastructure/hive/hive.dart';

part 'activity_hive_provider.g.dart';

@riverpod
class ActivityHive extends _$ActivityHive {
  @override
  void build() {}

  Box<Activity> _getBox() => Hive.box<Activity>(activityBox);

  int _getIndexFromId(String id) {
    return _getBox()
        .values
        .toList()
        .indexWhere((activity) => activity.id == id);
  }

  List<Activity> getAll() => _getBox().values.toList();

  Future<String> create(ActivityCreateDto activityCreateDto) async {
    final activity = Activity(
      id: tmUuid(),
      name: activityCreateDto.name,
      icon: activityCreateDto.icon,
      category: activityCreateDto.category,
    );

    await _getBox().add(activity);

    return activity.id;
  }

  Future<void> update(String id, Activity activity) async {
    await _getBox().putAt(_getIndexFromId(id), activity);
  }

  Future<void> delete(String id) async {
    await _getBox().deleteAt(_getIndexFromId(id));
  }
}
