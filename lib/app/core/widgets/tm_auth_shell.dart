import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me/app/core/core.dart';
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

    ref.read(userNotifierProvider.notifier).init();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userNotifierProvider);

    return user.when(
      logged: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
            if (!isAllowed) {
              AwesomeNotifications().requestPermissionToSendNotifications();
            }
          });
        });

        return TmLifecycleObserver(children: widget.child);
      },
      unlogged: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.replace('/login');
        });

        return const Scaffold();
      },
      unkown: () => const Scaffold(),
    );
  }
}
