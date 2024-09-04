import 'package:flutter/material.dart';

class TmLogo extends StatelessWidget {
  const TmLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/logo-white.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          'TrackMe',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
