// set halaman utama yang dibuka saat running main.dar

import 'package:flutter/material.dart';
import 'package:posture_guard_flutter/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // start the 3seconds delayed
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SplashScreen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Kamu akan berpindah halaman ke HomeScreen dalam 3 detik kemudian!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
