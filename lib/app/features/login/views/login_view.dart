import 'package:flutter/material.dart';
import 'package:track_me/app/core/core.dart';
import 'package:track_me/app/features/login/widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    final formHeigh = (screenHight / 2) > 320 ? screenHight / 2 : 320.0;

    return TmScaffold.fullScreen(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: screenHight - formHeigh,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login-background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: formHeigh,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/icons/logo-white.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'TrackMe',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Insert your name to start',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
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
