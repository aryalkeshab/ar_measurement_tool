import 'dart:async';

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

    // Example: Detect object and show border
    // Timer.periodic(Duration(milliseconds: 100), (timer) async {
    //   // Simulate camera feed data
    //   final imageData = await getCameraImage(
    //       arkitController); // Implement this to capture ARKit scene feed

    //   final detections =
    //       objectDetector.detectObjects(imageData); // Detect objects

    //   arkitController.remove('borderNode');
    //   for (var detection in detections) {
    //     // Extract bounding box and dimensions
    //     final x = detection['x'];
    //     final y = detection['y'];
    //     final width = detection['width'];
    //     final height = detection['height'];

    //     // Draw border
    //     final borderNode = ARKitNode(
    //       geometry: ARKitPlane(
    //         width: width.toDouble(),
    //         height: height.toDouble(),
    //         materials: [
    //           ARKitMaterial(
    //             diffuse: ARKitMaterialProperty.color(Colors.transparent),
    //             fillMode: ARKitFillMode.lines,
    //           ),
    //         ],
    //       ),
    //       position: vector.Vector3(x, y, -0.5),
    //     );

    //     // Add dimension text
    //     final textNode = ARKitNode(
    //       geometry: ARKitText(
    //         text:
    //             'H: ${height.toStringAsFixed(2)}m\nW: ${width.toStringAsFixed(2)}m',
    //         extrusionDepth: 0.01,
    //         materials: [
    //           ARKitMaterial(
    //             diffuse: ARKitMaterialProperty.color(Colors.white),
    //           ),
    //         ],
    //       ),
    //       position: vector.Vector3(x, y - 0.05, -0.5),
    //       scale: vector.Vector3(0.01, 0.01, 0.01),
    //     );

    //     arkitController.add(borderNode);
    //     arkitController.add(textNode);
    //   }
    // });
  }

  Future<List<double>> getCameraImage(ARKitController arkitController) async {
    ImageProvider<Object> imageProvider =
        await arkitController.getCapturedImage();

    // Implement a method to get the current ARKit view as an image and preprocess it
    return [];
  }

  // void onARKitViewCreated(ARKitController arkitController) {
  //   this.arkitController = arkitController;

  //   // Place the calibration sphere
  //   final sphereNode = ARKitNode(
  //     geometry: ARKitSphere(
  //       radius: 0.05, // 2 inches = 0.05 metersc
  //       materials: [
  //         ARKitMaterial(
  //           diffuse: ARKitMaterialProperty.color(Colors.red),
  //         )
  //       ],
  //     ),
  //     name: 'calibrationSphere',
  //     position: vector.Vector3(0, 0, -0.5), // 0.5 meters in front of the camera
  //   );

  //   arkitController.add(sphereNode);
  // }
}
