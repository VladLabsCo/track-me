import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me/app/core/core.dart';

class ActivityActions extends StatelessWidget {
  const ActivityActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
