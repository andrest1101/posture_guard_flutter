import 'package:flutter/material.dart';

class PosePainter extends CustomPainter {
  // variable penampung data dari luar
  final List<Offset> points;

  // constructor (colokan inputnya)
  PosePainter({required this.points});

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

    final Paint spidolPointBlue = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5;

    for (final pointBullet in points) {
      canvas.drawCircle(pointBullet, 10, spidolPointBlue);
    }

    if (points.length >= 6) {
      canvas.drawLine(points[0], points[1], spidolPointBlue);
      canvas.drawLine(points[1], points[2], spidolPointBlue);
      canvas.drawLine(points[2], points[3], spidolPointBlue);
      canvas.drawLine(points[3], points[4], spidolPointBlue);
      canvas.drawLine(points[4], points[5], spidolPointBlue);
    }
  }

  @override
  bool shouldRepaint(PosePainter oldDelegate) {
    return true;
  }

  @override
  bool shouldRebuildSemantics(PosePainter oldDelegate) => false;
}
