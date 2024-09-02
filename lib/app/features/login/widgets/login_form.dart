import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/login/providers/login_provider.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.read(loginNotifierProvider.notifier);

    Future<void> handleLogin() async {
      await loginNotifier.logIn();
      if (context.mounted) context.replace('/');
    }

    return Column(
      children: [
        TmInput(
          keyboardType: TextInputType.emailAddress,
          label: 'Name',
          icon: const Icon(CupertinoIcons.profile_circled),
          onChanged: loginNotifier.setName,
        ),
        const SizedBox(height: 30),
        TmButton(
          label: 'START',
          onPressed: handleLogin,
        ),
      ],
    );
  }
}
