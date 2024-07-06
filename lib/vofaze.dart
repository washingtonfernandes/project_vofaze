import 'package:flutter/material.dart';
import 'package:project_vofaze/services/roteador_tela.dart';
import 'package:project_vofaze/views/splash-screen/splash-screen.dart';

class Vofaze extends StatelessWidget {
  const Vofaze({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 5)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else {
            return const RoteadorTela();
          }
        },
      ),
    );
  }
}
