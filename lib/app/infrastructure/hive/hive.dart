import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
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
  Future<T> create(X activityCreateDto);
  Future<String> update(Y activityUpdateDto);
}

mixin HiveBoxAccessor<T extends HiveBoxDocument> {
  Box<T> getBox();
}

mixin HiveProviderMixin<T extends HiveBoxDocument> implements HiveBoxAccessor {
  @override
  Box<T> getBox();

  List<T> getAll() => getBox().values.toList();

  Future<void> delete(String id) async {
    await getBox().delete(id);
  }
}
