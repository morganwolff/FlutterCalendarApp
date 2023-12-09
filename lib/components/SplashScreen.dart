import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_app/common/components/TabBarNavigation.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkInitialisation() async {
    await Future.delayed(const Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkInitialisation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildLoadingScreen();
        } else {
          return const TabBarPage();
        }
      },
    );
  }

  Widget buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                'assets/calendar_animation.json', // Votre animation Lottie
                width: 600,
                height: 600,
                repeat: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
