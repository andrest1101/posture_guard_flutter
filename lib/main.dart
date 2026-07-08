import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:posture_guard_flutter/navigator.dart';

List<CameraDescription> cameras = [];

// 1. TAMBAHKAN ASYNC DI SINI
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HalamanSatu(), // kalau mau ganti ganti isi home tinggal ganti ke DashboardPage()
    ); 
  }
}

// ================= HALAMAN 1: DASHBOARD =================
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Ini adalah "Memori" tempat kita menyimpan semua path foto yang sudah di-take
  List<String> listFoto = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Guard')),
      body: SingleChildScrollView(
        // Agar halaman bisa di-scroll kalau foto sudah banyak
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Icon(Icons.app_registration, size: 80, color: Colors.blue),
            const SizedBox(height: 10),
            const Text(
              'Welcome to the Dashboard Guard App',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Tombol untuk membuka kamera
            ElevatedButton(
              onPressed: () async {
                // await di sini artinya Dashboard "menunggu" sampai CameraScreen ditutup
                final String? hasilFotoPath = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CameraScreen()),
                );

                // Jika hasilFotoPath tidak null (artinya user beneran take foto, bukan cuma back)
                if (hasilFotoPath != null) {
                  setState(() {
                    listFoto.add(hasilFotoPath); // Masukkan foto ke dalam memori list
                  });
                }
              },
              child: const Text('Open Camera Detector!'),
            ),

            const SizedBox(height: 30),
            const Divider(thickness: 2), // Garis pembatas
            const Text(
              '📁 Memori Penyimpanan Foto:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // KONDISI: Jika memori masih kosong
            if (listFoto.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Belum ada foto yang diambil.', style: TextStyle(color: Colors.grey)),
              ),

            // KONDISI: Jika sudah ada foto, kita tampilkan pakai GridView (Kotak-kotak)
            GridView.builder(
              shrinkWrap: true, // Membatasi tinggi GridView agar pas dengan konten
              physics:
                  const NeverScrollableScrollPhysics(), // Scroll utama dihandle oleh SingleChildScrollView
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Menampilkan 3 kolom kotak foto ke samping
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: listFoto.length,
              itemBuilder: (context, index) {
                final String pathAset = listFoto[index];

                // InkWell digunakan agar foto bisa di-tap/diklik
                return InkWell(
                  onTap: () {
                    // Berikan aksi saat foto di-tap, misalnya memunculkan pop-up dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Detail Foto #${index + 1}'),
                        content: Image.file(File(pathAset)), // Menampilkan gambar ukuran besar
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Tutup'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Mengambil file gambar dari storage HP secara proporsional di dalam kotak
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.file(File(pathAset), fit: BoxFit.cover),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ================= HALAMAN 2: CAMERA DETECTOR =================
class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    if (cameras.isNotEmpty) {
      // Ubah ke cameras[0] untuk kamera utama/belakang terlebih dahulu
      controller = CameraController(cameras[0], ResolutionPreset.ultraHigh);

      controller!.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 2. JIKA KAMERA BELUM SIAP -> Tampilkan Loading Spinner biasa
    if (controller == null || !controller!.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // 3. JIKA KAMERA SUDAH SIAP -> Tampilkan Live Feed Kamera dan Tombol
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: AspectRatio(
              aspectRatio: controller!.value.aspectRatio,
              child: CameraPreview(controller!),
            ),
          ),

          // leatakkan tombol bagian bawah melayang
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 2/ Tombol utama : take foto (bentuk bulat)
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () async {
                    try {
                      // fungsi bawaan package camera untuk mengambil gambar
                      final XFile foto = await controller!.takePicture();

                      if (!mounted) return;

                      // Tutup halaman kamera dan kirim path foto kembali ke Dashboard!
                      Navigator.pop(context, foto.path);
                    } catch (e) {
                      print("Gagal mengambil gambar:$e");
                    }
                  },
                  child: const Icon(Icons.camera_alt, color: Colors.black),
                ),

                const SizedBox(height: 10),

                // 1. Tombol Kembali (Batall)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Kembali Ke Dashboard', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
