import 'package:camera/camera.dart';
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
    // step 1: conversion to InputImage
    final InputImage inputImage = InputImage.fromBytes(
      bytes: cameraImage.planes[0].bytes,
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

    pose.landmarks.forEach((Type, landmark) {
      points.add(Offset(landmark.x, landmark.y));
    });

    return points;
  }
}
