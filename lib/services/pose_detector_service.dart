import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PoseDetectorService {
  // the detection machine
  final PoseDetector _poseDetector = PoseDetector(options: PoseDetectorOptions());

  // frame processing function
  // Fungsi pemroses frame

  Future<List<Offset>> detectPose({
    required CameraImage cameraImage,
    required int sensorOrientation,
  }) async {
    //prepare an empty container for sewing data
    final WriteBuffer allBytes = WriteBuffer();

    // looping to insert the three image layers (planes) into the container
    for (final Plane plane in cameraImage.planes) {
      allBytes.putUint8List(plane.bytes);
    }

    // lock the key to the container becomes a single, complete piece of data
    final bytes = allBytes.done().buffer.asUint8List();

    final InputImage inputImage = InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(cameraImage.width.toDouble(), cameraImage.height.toDouble()),
        rotation:
            InputImageRotationValue.fromRawValue(sensorOrientation) ??
            InputImageRotation.rotation0deg,
        format: InputImageFormat.nv21,
        bytesPerRow: cameraImage.planes[0].bytesPerRow,
      ),
    );

    // step 2 : process with MLKit
    final List<Pose> poses = await _poseDetector.processImage(inputImage);

    // step 3: take coordinates and return
    if (poses.isEmpty) {
      return [];
    }

    final List<Offset> points = [];
    final Pose pose = poses.first;

    //1. select a specific points
    final kupingKiri = pose.landmarks[PoseLandmarkType.leftEar];
    final kupingKanan = pose.landmarks[PoseLandmarkType.rightEar];
    final bahuKiri = pose.landmarks[PoseLandmarkType.leftShoulder];
    final bahuKanan = pose.landmarks[PoseLandmarkType.rightShoulder];
    final bahuBawahKiri = pose.landmarks[PoseLandmarkType.leftHip];
    final bahuBawahKanan = pose.landmarks[PoseLandmarkType.rightHip];

    //2. ensure the AI successfully detects these three points on the screen
    if (kupingKiri != null &&
        kupingKanan != null &&
        bahuKiri != null &&
        bahuKanan != null &&
        bahuBawahKiri != null &&
        bahuBawahKanan != null) {
      // put in drawer 0 = leftEar
      points.add(Offset(kupingKiri.x, kupingKanan.y));

      // put in drawer 1 = rightEar
      points.add(Offset(kupingKanan.x, kupingKanan.y));

      // put in drawer 2 = leftShoulder
      points.add(Offset(bahuKiri.x, bahuKiri.y));

      // put in drawer 3 = rightShoulder
      points.add(Offset(bahuKanan.x, bahuKanan.y));

      // put in drawer 4 = leftHip
      points.add(Offset(bahuBawahKiri.x, bahuBawahKiri.y));

      // put in drawer 5 = rightHip
      points.add(Offset(bahuBawahKanan.x, bahuBawahKanan.y));
    }

    return points;
  }
}
