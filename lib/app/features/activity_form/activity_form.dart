import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/activity_form/providers/activity_form_provider.dart';

class ActivityForm extends ConsumerWidget {
  const ActivityForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> handleSubmit() async {
      await ref.read(activityFormProvider.notifier).submit();
      if (context.mounted) context.pop();
    }

    return TmScaffold.nested(
      removePaddingTop: true,
      title: 'New Activity',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter activity data to save',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 30),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TmInput(
                    label: 'Name',
                    icon: const Icon(
                      CupertinoIcons.bolt_circle,
                      color: Colors.white,
                    ),
                    onChanged: ref.watch(activityFormProvider.notifier).setName,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: TmButton(
              label: 'Save',
              onPressed: handleSubmit,
            ),
          ),
        ],
      ),
    );
  }
}
