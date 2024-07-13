import 'package:flutter/material.dart';
import 'package:project_vofaze/services/provider/auth_service_provider.dart';
import 'package:project_vofaze/views/home/home.dart';
import 'package:project_vofaze/vofaze.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    

    if (auth.isLoading) {
      return loading();
    } else if (auth.usuario == null) {
      return const Vofaze();
    } else {
      return const Home();
    }
  }

  loading() {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(
                    value:
                        null,
                    strokeWidth:
                        2,
                    color: Colors.black,
                  )),
    );
  }
}
