import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:track_me/app/infrastructure/hive/adapters/datetime_adapter.dart';
import 'package:track_me/app/infrastructure/hive/adapters/duration_adapter.dart';
import 'package:track_me/app/infrastructure/hive/models/activity.dart';
import 'package:track_me/app/infrastructure/hive/models/activity_stats.dart';
import 'package:track_me/app/infrastructure/hive/models/activity_type.dart';

// Models
export 'models/activity.dart';
export 'models/activity_stats.dart';
export 'models/activity_type.dart';

// Providers
export 'providers/activity_hive_provider.dart';
export 'providers/activity_stats_hive_provider.dart';
export 'providers/activity_type_hive_provider.dart';

// Widgets
export 'widgets/hive_wrapper.dart';

const activityTypeBox = 'activityTypeBox';
const activityStatsBox = 'activityStatsBox';
const activityBox = 'activityBox2';

Future<void> initHive() async {
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);

  Hive
    ..registerAdapter(DurationAdapter())
    ..registerAdapter(DatetimeAdapter())
    ..registerAdapter(ActivityAdapter())
    ..registerAdapter(ActivityTypeAdapter())
    ..registerAdapter(ActivityStatsAdapter());

  await Hive.openBox<ActivityType>(activityTypeBox);
  await Hive.openBox<ActivityStats>(activityStatsBox);
  await Hive.openBox<Activity>(activityBox);
}

// Providers mixin and abstract classes
abstract class HiveBoxDocument {
  String get id;
}

abstract class HiveProviderBase<T extends HiveBoxDocument, X, Y> {
  Box<T> getBox();
  Future<String> create(X activityCreateDto);
  Future<String> update(String id, Y activityUpdateDto);
}

mixin HiveBoxAccessor<T extends HiveBoxDocument> {
  Box<T> getBox();
}

mixin HiveProviderMixin<T extends HiveBoxDocument> implements HiveBoxAccessor {
  @override
  Box<T> getBox();

  int getIndexFromId(String id) {
    return getBox().values.toList().indexWhere((activity) => activity.id == id);
  }

  List<T> getAll() => getBox().values.toList();

  Future<void> delete(String id) async {
    await getBox().deleteAt(getIndexFromId(id));
  }
}
