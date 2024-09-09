import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/login/providers/login_provider.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> handleLogin() async {
      await ref.read(loginNotifierProvider.notifier).logIn();
      if (context.mounted) context.replace('/');
    }

    return Column(
      children: [
        const SizedBox(height: 20),
        TmInput(
          keyboardType: TextInputType.emailAddress,
          label: 'Name',
          icon: const Icon(
            CupertinoIcons.profile_circled,
            color: Colors.white,
          ),
          onChanged: ref.watch(loginNotifierProvider.notifier).setName,
        ),
        const SizedBox(height: 25),
        TmButton(
          label: 'START',
          onPressed: handleLogin,
        ),
      ],
    );
  }
}
