import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class BasicCalibrationController extends GetxController {
  late ARKitController arkitController;
  ARKitReferenceNode? node;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    // Place the calibration sphere
    final sphereNode = ARKitNode(
      geometry: ARKitSphere(
        radius: 0.05, // 2 inches = 0.05 metersc
        materials: [
          ARKitMaterial(
            diffuse: ARKitMaterialProperty.color(Colors.red),
          )
        ],
      ),
      name: 'calibrationSphere',
      position: vector.Vector3(0, 0, -0.5), // 0.5 meters in front of the camera
    );

    arkitController.add(sphereNode);
  }
}
