import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      ),
      onPressed: onPressed,
      child: Text(
        'START',
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
