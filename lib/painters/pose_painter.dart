import 'package:flutter/material.dart';

class PosePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // speedol point green
    final Paint spidolPointHijau = Paint()
      ..color = Colors.green
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final Paint spidolPointBlue = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final Paint spidolPointWhite = Paint()
      ..color = Colors.white
      ..strokeWidth = 3;

    canvas.drawCircle(const Offset(100, 200), 5, spidolPointHijau);
    canvas.drawCircle(const Offset(110, 250), 30, spidolPointBlue);
    canvas.drawCircle(const Offset(200, 250), 20, spidolPointWhite);


    // gabungin
  }

  @override
  bool shouldRepaint(PosePainter oldDelegate) {
    return true;
  }

  @override
  bool shouldRebuildSemantics(PosePainter oldDelegate) => false;
}
