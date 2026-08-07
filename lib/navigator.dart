import 'package:flutter/material.dart';

class HalamanSatu extends StatefulWidget {
  const HalamanSatu({super.key});
  @override
  State<HalamanSatu> createState() => _HalamanSatuState();
}

class _HalamanSatuState extends State<HalamanSatu> {
  // this is allow to access the textfield  text
  final TextEditingController textPengontrolnya = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Navigator Push and Pop ',
          style: TextStyle(fontWeight: FontWeight.w300, color: Colors.blue, fontSize: 25),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Andre Learn How to Make and Use Navigator to switch from page 1 to page 2 ',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            const SizedBox(height: 20),

            // for textfield
            Padding(
              padding: const EdgeInsets.all(32),
              child: TextField(
                controller: textPengontrolnya,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.lightBlue,
                ),
              ),
            ),

            // tombol untuk switch dari page 1 to page 2 menggunakan ElevatedButton
            ElevatedButton(
              child: Text('Pindah Ke halaman-2'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HalamanDua(nama: textPengontrolnya.text)),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class HalamanDua extends StatelessWidget {
  const HalamanDua({super.key, required this.nama});
  final String nama;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ini adalah Halaman Dua')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              nama,
              style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            const Text(
              'Selamat , Kamu Berhasil berpindah dari halaman ke-1 ke halaman-2',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.blue),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // make a button for previous page is HalamanSatu() page.
            ElevatedButton(
              child: const Text('Kembali ke Halaman-1'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
