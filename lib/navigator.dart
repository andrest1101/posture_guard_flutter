import 'package:flutter/material.dart';

class HalamanSatu extends StatelessWidget {
  const HalamanSatu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Navigator Page Push and Pop',
          style: TextStyle(fontWeight: FontWeight.w300, color: Colors.blue),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Andre Learn how to Make Two Page With Navigator Push',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 170),
            ElevatedButton(
              child: const Text('Masuk Ke Halaman-2'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HalamanDua()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HalamanDua extends StatelessWidget {
  const HalamanDua({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kembali Ke halaman Utama ',
          style: TextStyle(fontWeight: FontWeight.w200, fontSize: 20),
          textAlign: TextAlign.left,
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Selamat datang di Halaman Kedua'),
            ElevatedButton(
              child: const Text('Kembali Ke Halaman-1'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
