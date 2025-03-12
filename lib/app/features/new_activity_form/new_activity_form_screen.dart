import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/new_activity_form/providers/new_activity_form_provider.dart';

class NewActivityFormScreen extends ConsumerWidget {
  const NewActivityFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> handleSubmit() async {
      final hasSaved = await ref.read(activityFormProvider.notifier).submit();
      if (hasSaved && context.mounted) context.pop();
    }

    return TmScaffold.nested(
      title: 'New Activity',
      subtitle: 'Enter all details to create a new activity.',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            child: TmButton(onPressed: handleSubmit, 'Save'),
          ),
        ],
      ),
    );
  }
}
