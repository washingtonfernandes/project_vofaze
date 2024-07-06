import 'package:flutter/material.dart';

class BackImage extends StatelessWidget {
  const BackImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fundo_app.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
