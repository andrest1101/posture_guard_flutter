import 'dart:math';

import 'package:flutter/widgets.dart';

double hitungSudut(Offset a, Offset b, Offset c) {
  // calculate the vector from B to A and from A to B
  final double sudutBA = atan2(a.dy - b.dy, a.dx - b.dx);
  final double sudutBC = atan2(c.dy - b.dy, c.dx - b.dx);

  // calculate angle difference and convert to degrees
  double sudut = (sudutBA - sudutBC) * (180 / pi);

  // make sure the value is always positif
  if (sudut < 0) sudut += 360;

  return sudut;
}

// classification logic
String klasifikasiPostur(double sudut) {
  // sudut 160
  if (sudut > 160) {
    return "Baik";
  } else if (sudut > 130) {
    return "Perlu diperbaiki";
  } else {
    return "Buruk";
  }
}
