import 'package:flutter/material.dart';

class PosePainter extends CustomPainter {
  // variable penampung data dari luar
  final List<Offset> points;

  // variable penampung status dari luar
  String statusBaru;

  // variable baru untuk ganti ganti warna sesuai dengan logika klasifikasi angle_calculator.dart
  Color warnaAktif = Colors.green;

  // constructor (colokan inputnya)
  PosePainter({required this.points, required this.statusBaru});

  @override
  void paint(Canvas canvas, Size size) {
    // logika untuk menentukan warna spidolPoint berdasarkan nilai klasifikasi postur
    if (statusBaru == "Perlu diperbaiki") {
      warnaAktif = Colors.yellow;
    } else if (statusBaru == "Buruk") {
      warnaAktif = Colors.red;
    } else {
      warnaAktif;
    }

    final Paint spidolPoint = Paint()
      ..color = warnaAktif
      ..strokeWidth = 5;

    for (final pointBullet in points) {
      canvas.drawCircle(pointBullet, 10, spidolPoint);
    }

    if (points.length >= 6) {
      canvas.drawLine(points[0], points[1], spidolPoint);
      canvas.drawLine(points[1], points[2], spidolPoint);
      canvas.drawLine(points[2], points[3], spidolPoint);
      canvas.drawLine(points[3], points[4], spidolPoint);
      canvas.drawLine(points[4], points[5], spidolPoint);
    }
  }

  @override
  bool shouldRepaint(PosePainter oldDelegate) {
    return true;
  }

  @override
  bool shouldRebuildSemantics(PosePainter oldDelegate) => false;
}
