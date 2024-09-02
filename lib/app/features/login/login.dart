import 'package:flutter/widgets.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/login/widgets/login_form.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return TmScaffold.fullScreen(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login-background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'TrackMe',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Insert your name to start',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const LoginForm(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
