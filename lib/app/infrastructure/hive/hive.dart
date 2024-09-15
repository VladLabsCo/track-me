import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:track_me/app/infrastructure/hive/models/activity.dart';

// Models
export 'models/activity.dart';

// Providers
export 'providers/activity_hive_provider.dart';

// Widgets
export 'widgets/hive_wrapper.dart';

const activityBox = 'activityBox';

Future<void> initHive() async {
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);

  Hive.registerAdapter(ActivityAdapter());

  await Hive.openBox<Activity>(activityBox);
}
