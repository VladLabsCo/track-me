import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me/app/core/core.dart';

class ActivityTitleActions extends ConsumerWidget {
  const ActivityTitleActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref
        .watch(userNotifierProvider)
        .maybeWhen(orElse: () => '', logged: (name) => name);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You are doing great, $userName!',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            TmButton(
              size: TmButtonSize.small,
              outlined: true,
              rightIcon: const Icon(
                CupertinoIcons.chevron_right,
                color: Colors.white,
                size: 15,
              ),
              onPressed: () => context.go('/type-management'),
              'Manage Activities',
            ),
          ],
        ),
      ],
    );
  }
}
