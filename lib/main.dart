import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_vofaze/vofaze.dart';
import 'firebase_options.dart';
import 'package:project_vofaze/services/provider/app_providers.dart'; // Importe aqui a função getAppProviders

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    Builder(
      builder: (context) => getAppProviders(
        context,
        const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Vofaze(),
        ),
      ),
    ),
  );
}
