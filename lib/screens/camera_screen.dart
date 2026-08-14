import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:posture_guard_flutter/main.dart';
import 'package:posture_guard_flutter/painters/pose_painter.dart';
import 'package:posture_guard_flutter/screens/summary_screen.dart';
import 'package:posture_guard_flutter/services/pose_detector_service.dart';
import 'package:posture_guard_flutter/utilities/angle_calculator.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controlTheCamera;
  int selectedCameraIndex = 0;

  // variable for pose_detector_service
  final PoseDetectorService _poseDetectorService = PoseDetectorService();

  // list of detection result coordinates
  List<Offset> _posePoints = [];

  // varibale for angle_calculator
  String _statusPosture = "Mendeteksi...";
  double _nilaiSudut = 0.0;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  // for camera initialization

  void initCamera() async {
    await Future.delayed(const Duration(milliseconds: 700));

    controlTheCamera = CameraController(cameras[selectedCameraIndex], ResolutionPreset.high);

    controlTheCamera!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});

      controlTheCamera!.startImageStream((CameraImage image) async {
        final List<Offset> points = await _poseDetectorService.detectPose(
          cameraImage: image,
          sensorOrientation: controlTheCamera!.description.sensorOrientation,
        );

        if (mounted) {
          // minimum logic point 5
          if (points.length >= 5) {
            final double sudutBaru = hitungSudut(points[0], points[2], points[3]);
            final String statusBaru = klasifikasiPostur(sudutBaru);

            setState(() {
              _posePoints = points;
              _nilaiSudut = sudutBaru;
              _statusPosture = statusBaru;
            });
          }
        }
      });
    });
  }

  // for switch camera

  void onSwitchCamera() {
    if (selectedCameraIndex == 0) {
      selectedCameraIndex = 1;
    } else {
      selectedCameraIndex = 0;
    }
    controlTheCamera?.dispose();
    initCamera();
  }

  // for finish button

  void finishButton() {
    Navigator.pop(context);
  }

  // for camera dispose

  @override
  void dispose() {
    controlTheCamera?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controlTheCamera == null || !controlTheCamera!.value.isInitialized) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    } else {
      return Scaffold(
        body: Stack(
          children: [
            // for camera preview and control full the ratio
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controlTheCamera!.value.previewSize!.height,
                  height: controlTheCamera!.value.previewSize!.width,

                  // wrap with stack in here
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // old video
                      CameraPreview(controlTheCamera!),

                      Transform.scale(
                        // Kalau selectedCameraIndex == 1 (Kamera Depan), balikkan kanvasnya (-1)
                        // Kalau 0 (Kamera Belakang), biarkan normal (1)
                        scaleX: selectedCameraIndex == 1 ? -1 : 1,
                        alignment: Alignment.center,
                        child: CustomPaint(painter: PosePainter(points: _posePoints)),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              top: 650,
              right: 20,
              child: FloatingActionButton(
                onPressed: onSwitchCamera,
                child: const Icon(Icons.switch_camera_sharp),
              ),
            ),

            // for finish button
            Positioned(
              top: 655,
              left: 150,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SummaryScreen(Duration: 120, GoodPosture: 130),
                      ),
                    );
                  },
                  child: const Text('Finish'),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
