import 'package:flutter/material.dart';
import 'package:project_vofaze/common/backImage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controllerLoading;
  late final Animation<AlignmentGeometry> animationLoading;
  late final Animation<AlignmentGeometry> animationLoading2;

  @override
  void initState() {
    super.initState();
    controllerLoading = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    animationLoading = Tween<AlignmentGeometry>(
      begin: Alignment.centerLeft,
      end: Alignment.center,
    ).animate(
      CurvedAnimation(parent: controllerLoading, curve: Curves.linear),
    );

    animationLoading2 = Tween<AlignmentGeometry>(
      begin: Alignment.bottomRight,
      end: Alignment.center,
    ).animate(
      CurvedAnimation(parent: controllerLoading, curve: Curves.linear),
    );

    controllerLoading.forward();
  }

  @override
  void dispose() {
    controllerLoading.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fundo_app.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            const BackImage(),
            Positioned(
              top: size.height * 0.32,
              left: size.width * 0.015,
              right: size.width * 0.015,
              child: SizedBox(
                width: size.width * 0.30,
                height: size.height * 0.20,
                child: Image.asset('assets/splash/splash_0.png'),
              ),
            ),
            Positioned(
              top: size.height * 0.42,
              left: -290,
              right: -290,
              child: AlignTransition(
                alignment: animationLoading,
                child: SizedBox(
                  width: size.width * 0.25,
                  height: size.height * 0.10,
                  child: Image.asset('assets/splash/splash_1.png'),
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.34,
              left: -295,
              right: -290,
              child: AlignTransition(
                alignment: animationLoading2,
                child: SizedBox(
                  width: size.width * 0.25,
                  height: size.height * 0.12,
                  child: Image.asset('assets/splash/splash_2.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
