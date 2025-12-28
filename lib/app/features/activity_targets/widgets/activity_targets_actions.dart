import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me/app/core/widgets/tm_button.dart';

class ActivityTargetActions extends StatelessWidget {
  const ActivityTargetActions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TmButton(
        'New target',
        outlined: true,
        leftIcon: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
          size: 18,
        ),
        onPressed: () => context.go('/new-target'),
      ),
    );
  }
}
