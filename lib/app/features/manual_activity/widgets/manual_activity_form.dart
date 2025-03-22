import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/manual_activity/providers/manual_activity_form_provider.dart';

class ManualActivityForm extends ConsumerWidget {
  const ManualActivityForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(manualActivityFormNotifierProvider);

    final canSubmit = formState.duration != Duration.zero &&
        ref.watch(activityTypeNotifierProvider).active != null;

    Future<void> handleSave() async {
      await ref.watch(manualActivityFormNotifierProvider.notifier).save();
      if (context.mounted) context.pop();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text('Pick the activity'),
        const SizedBox(height: 10),
        const ActivityPicker(forForm: true),
        const SizedBox(height: 20),
        const Text('Select the date'),
        const SizedBox(height: 10),
        DateInput(
          value: formState.date,
          onChanged: ref
              .watch(
                manualActivityFormNotifierProvider.notifier,
              )
              .setDate,
        ),
        const SizedBox(height: 20),
        const Text('Set the duration'),
        const SizedBox(height: 10),
        DurationInput(
          value: formState.duration,
          onChanged: ref
              .watch(
                manualActivityFormNotifierProvider.notifier,
              )
              .setDuration,
        ),
        const SizedBox(height: 40),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              child: TmButton(
                'SAVE',
                onPressed: canSubmit ? handleSave : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
