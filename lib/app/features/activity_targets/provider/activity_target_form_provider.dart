import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:track_me/app/features/activity_targets/provider/state/activity_target_form_state.dart';
import 'package:track_me/app/infrastructure/infrastructure.dart';

part 'activity_target_form_provider.g.dart';

@riverpod
class ActivityTargetFormNotifier extends _$ActivityTargetFormNotifier {
  @override
  ActivityTargetFormState build() => ActivityTargetFormState.initial();

  void setType(ActivityType type) => state = state.copyWith(activityType: type);
}
