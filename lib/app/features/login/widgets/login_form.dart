import 'package:flutter/cupertino.dart';
import 'package:track_me/app/features/login/widgets/login_button.dart';
import 'package:track_me/app/features/login/widgets/login_input.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: [
          LoginInput(
            keyboardType: TextInputType.emailAddress,
            label: 'Name',
            controller: nameController,
            icon: const Icon(CupertinoIcons.profile_circled),
          ),
          const SizedBox(height: 30),
          LoginButton(onPressed: () {}),
        ],
      ),
    );
  }
}
