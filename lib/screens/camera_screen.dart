import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:posture_guard_flutter/main.dart';
import 'package:posture_guard_flutter/painters/pose_painter.dart';
import 'package:posture_guard_flutter/screens/summary_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controlTheCamera;
  int selectedCameraIndex = 0;

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
                  child: CameraPreview(controlTheCamera!),
                ),
              ),
            ),

            Positioned.fill(child: CustomPaint(painter: PosePainter(
              Points: [
                const Offset(100, 200),
                const Offset(150, 200),
                const Offset(200, 300)
                
              ]
            ))),

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
