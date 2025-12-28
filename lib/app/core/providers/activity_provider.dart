import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/core/providers/state/activity_state.dart';
import 'package:track_me/app/infrastructure/hive/providers/activity_hive_provider.dart';

part 'activity_provider.g.dart';

@Riverpod(keepAlive: true)
class ActivityNotifier extends _$ActivityNotifier {
  @override
  ActivityState build() {
    return ActivityState.inital(
      ref.read(activityHiveProvider.notifier).getAll(),
    );
  }
}
