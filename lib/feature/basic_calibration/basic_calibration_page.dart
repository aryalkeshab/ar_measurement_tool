import 'package:ar_measurement_tool/feature/home/home_screen.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import 'basic_calibration_controller.dart';

class BasicCalibrationPage extends StatelessWidget {
  static String routeName = "/basic_calibration";

  const BasicCalibrationPage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(BasicCalibrationController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('AR Calibration View'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.offAllNamed(HomeScreen.routeName);
          },
        ),
      ),
      body: GetBuilder<BasicCalibrationController>(builder: (c) {
        return ARKitSceneView(
          onARKitViewCreated: c.onARKitViewCreated,
          showFeaturePoints: true,
          planeDetection: ARPlaneDetection.horizontal,
        );
      }),
    );
  }
}
