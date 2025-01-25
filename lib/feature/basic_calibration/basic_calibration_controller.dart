import 'dart:async';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class BasicCalibrationController extends GetxController {
  late ARKitController arkitController;

  final List<vector.Vector3> selectedPoints = [];
  final List<String> nodeNames = []; // Track node names
  String measurementUnit = 'cm'; // Default unit

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    // Handle taps in the ARKit scene
    this.arkitController.onARTap = (ar) {
      final point = ar.firstWhereOrNull(
        (o) => o.type == ARKitHitTestResultType.featurePoint,
      );
      if (point != null) {
        _handleTap(point);
      }
    };
  }

  void _handleTap(ARKitTestResult point) {
    // Convert the world transform to a Vector3 position
    final position = vector.Vector3(
      point.worldTransform.getColumn(3).x,
      point.worldTransform.getColumn(3).y,
      point.worldTransform.getColumn(3).z,
    );

    final sphereNodeName = 'sphere_${nodeNames.length}';
    final sphere = ARKitSphere(
      radius: 0.006,
      materials: [
        ARKitMaterial(
          lightingModelName: ARKitLightingModel.constant,
          diffuse: ARKitMaterialProperty.color(Colors.green),
        ),
      ],
    );
    final sphereNode = ARKitNode(
      geometry: sphere,
      position: position,
      name: sphereNodeName,
    );
    arkitController.add(sphereNode);
    nodeNames.add(sphereNodeName);

    // Add the point to the list
    selectedPoints.add(position);

    if (selectedPoints.length == 4) {
      _calculateDimensions();
    }
  }

  void _calculateDimensions() {
    if (selectedPoints.length == 4) {
      // Extract the 4 points
      final p1 = selectedPoints[0];
      final p2 = selectedPoints[1];
      final p3 = selectedPoints[2];
      final p4 = selectedPoints[3];

      // Calculate width, height, and depth
      final width = _calculateDistance(p1, p2);
      final height = _calculateDistance(p2, p3);
      final depth = _calculateDistance(p3, p4);

      // Show the calculated dimensions
      Get.snackbar(
        'Object Dimensions',
        'Width: $width, Height: $height, Depth: $depth',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Reset points for the next measurement
      _resetPoints();
    }
  }

  double _calculateDistance(vector.Vector3 A, vector.Vector3 B) {
    final distanceInMeters = A.distanceTo(B);
    if (measurementUnit == 'cm') {
      return distanceInMeters * 100; // Convert to cm
    } else if (measurementUnit == 'inch') {
      return distanceInMeters * 39.3701; // Convert to inches
    }
    return distanceInMeters * 100; // Default to cm
  }

  void _resetPoints() {
    // Remove all nodes and reset state
    for (final nodeName in nodeNames) {
      arkitController.remove(nodeName);
    }
    selectedPoints.clear();
    nodeNames.clear();
  }

  void changeMeasurementUnit(String unit) {
    measurementUnit = unit;
    update();
  }
}
