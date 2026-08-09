import 'package:flutter/material.dart';

class PosePainter extends CustomPainter {
  // variable penampung data dari luar
  final List<Offset> Points;

  // constructor (colokan inputnya)
  PosePainter({required this.Points});

  @override
  void paint(Canvas canvas, Size size) {
    // speedol point green
    final Paint spidolPointHijau = Paint()
      ..color = Colors.green
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final Paint spidolPointWhite = Paint()
      ..color = Colors.white
      ..strokeWidth = 3;

    final Paint spidolPointBlue = Paint()..color = Colors.blue;

    for (final PointBullet in Points) {
      canvas.drawCircle(PointBullet, 10, spidolPointBlue);
    }
  }

  @override
  bool shouldRepaint(PosePainter oldDelegate) {
    return true;
  }

  @override
  bool shouldRebuildSemantics(PosePainter oldDelegate) => false;
}
