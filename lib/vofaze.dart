import 'package:flutter/material.dart';
import 'package:project_vofaze/pages/login.page.dart';
import 'package:project_vofaze/pages/splashscreen.dart';

class vofaze extends StatelessWidget {
  const vofaze({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 5)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
