import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/core/providers/state/user_state.dart';

class ActivityStatsTitle extends ConsumerWidget {
  const ActivityStatsTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider);

    late String userName;
    if (user is LoggedUser) {
      userName = user.name;
    } else {
      userName = '';
    }

    return Text(
      'Keep it up $userName!',
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
