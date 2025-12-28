import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/core/widgets/inputs/activity_picker.dart';
import 'package:track_me/app/features/activity_targets/provider/activity_target_form_provider.dart';

class ActivityTargetForm extends ConsumerWidget {
  const ActivityTargetForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(activityTargetFormNotifierProvider);
    final formNotifier = ref.watch(activityTargetFormNotifierProvider.notifier);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 10),
      const Text('Pick the activity'),
      const SizedBox(height: 10),
      ActivityPicker(
        forForm: true,
        value: formState.activityType,
        onChanged: formNotifier.setType,
      ),
      const SizedBox(height: 20),
    ]);
  }
}
