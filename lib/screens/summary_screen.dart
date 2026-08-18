import 'package:flutter/material.dart';
import 'package:posture_guard_flutter/screens/home_screen.dart';

class SummaryScreen extends StatelessWidget {
  final int duration;
  final int goodPosture;
  const SummaryScreen({super.key, required this.duration, required this.goodPosture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SummaryScreen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selamat Kamu berhasil masuk ke page SummaryScreen, dan kami menangkap informasi dari penggunaan aplikasi PostureGuard adalah: duration: $duration Detik dan Goodposture: $goodPosture Detik (Perfect!)',
              style: TextStyle(fontSize: 16, color: Colors.lightBlue),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            // use elevated button to previuous page (homePage)
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
              child: const Text('Kembali ke HomePage'),
            ),
          ],
        ),
      ),
    );
  }
}
