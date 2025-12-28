import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/core/providers/state/user_state.dart';
import 'package:track_me/app/core/widgets/tm_lifecycle_observer.dart';

class TmAuthShell extends ConsumerStatefulWidget {
  const TmAuthShell({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<TmAuthShell> createState() => _TmAuthShellState();
}

class _TmAuthShellState extends ConsumerState<TmAuthShell> {
  @override
  void initState() {
    super.initState();

    ref.read(userProvider.notifier).init();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    if (user is LoggedUser) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
          if (!isAllowed) {
            AwesomeNotifications().requestPermissionToSendNotifications();
          }
        });
      });

      return TmLifecycleObserver(children: widget.child);
    }

    if (user is UnloggedUser) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.replace('/login');
      });
    }

    return const Scaffold();
  }
}
