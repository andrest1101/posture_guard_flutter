import 'package:flutter/material.dart';
import 'package:posture_guard_flutter/screens/camera_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomeScreen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Kamu sekarang berada di HomeScreen!', style: TextStyle(color: Colors.blue)),
            const SizedBox(height: 40),

            // use the elevated button to swtich from HomeScreen to CameraScreen
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CameraScreen()));
              },
              child: const Text('Pindah ke CameraScreen'),
            ),
          ],
        ),
      ),
    );
  }
}
