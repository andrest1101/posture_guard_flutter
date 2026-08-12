import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:posture_guard_flutter/screens/splash_screen.dart';

// 1. TAMBAHKAN ASYNC DI SINI
List<CameraDescription> cameras = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras(); // 2. TUNGGU SAMPAI CAMERA TERSEDIA
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // kalau mau ganti ganti isi home tinggal ganti ke DashboardPage()
    );
  }
}
