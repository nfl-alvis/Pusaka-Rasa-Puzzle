import 'package:flutter/material.dart';

class TentangGame extends StatelessWidget {
  const TentangGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/Bg.jpg',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}