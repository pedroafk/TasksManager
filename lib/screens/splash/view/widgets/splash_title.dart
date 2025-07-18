import 'package:flutter/material.dart';

class SplashTitle extends StatelessWidget {
  const SplashTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Tasks Manager',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w900,
        fontFamily: 'Montserrat',
        letterSpacing: 2,
        color: Color.fromARGB(255, 0, 0, 0),
        shadows: [
          Shadow(blurRadius: 4, color: Colors.black26, offset: Offset(2, 2)),
        ],
      ),
    );
  }
}
