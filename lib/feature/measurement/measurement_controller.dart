import 'package:ar_measurement_tool/feature/measurement/meaurement_data_model.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class MeasurementController extends GetxController {
  late ARKitController arkitController;
  vector.Vector3? lastPosition;
  final List<String> nodeNames = []; // Keep track of all node names
  String measurementUnit = 'cm';
  final List<MeasurementData> measurements = []; // Tracks measurement data

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  void updateMeasurementUnit(String newUnit) {
    measurementUnit = newUnit;

    // Update all existing measurement text nodes
    for (var measurement in measurements) {
      final updatedDistance = _calculateDistanceBetweenPoints(
        measurement.startPosition,
        measurement.endPosition,
      );
      _updateTextNode(
          measurement.textNodeName, updatedDistance, measurement.textPosition);
    }

    update(); // Refresh UI
  }

  void removeAllPreviousPositions() {
    for (final nodeName in nodeNames) {
      arkitController.remove(nodeName);
    }
    nodeNames.clear();
    measurements.clear(); // Clear measurement data
    lastPosition = null;
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onARTap = (ar) {
      final point = ar.firstWhereOrNull(
        (o) => o.type == ARKitHitTestResultType.featurePoint,
      );
      if (point != null) {
        _onARTapHandler(point);
      }
    };
  }

  void _onARTapHandler(ARKitTestResult point) {
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
          diffuse: ARKitMaterialProperty.color(Colors.blue),
        )
      ],
    );
    final sphereNode = ARKitNode(
      geometry: sphere,
      position: position,
      name: sphereNodeName,
    );
    arkitController.add(sphereNode);
    nodeNames.add(sphereNodeName);

    if (lastPosition != null) {
      final lineNodeName = 'line_${nodeNames.length}';
      final line = ARKitLine(
        fromVector: lastPosition!,
        toVector: position,
      );
      final lineNode = ARKitNode(geometry: line, name: lineNodeName);
      arkitController.add(lineNode);
      nodeNames.add(lineNodeName);

      final distance = _calculateDistanceBetweenPoints(position, lastPosition!);
      final textPosition = _getMiddleVector(position, lastPosition!);
      final textNodeName = _drawText(distance, textPosition);

      // Track measurement data
      measurements.add(
        MeasurementData(
          startPosition: lastPosition!,
          endPosition: position,
          textNodeName: textNodeName,
          textPosition: textPosition,
        ),
      );
    }
    lastPosition = position;
  }

  String _calculateDistanceBetweenPoints(vector.Vector3 A, vector.Vector3 B) {
    final lengthInMeters = A.distanceTo(B);
    if (measurementUnit == 'cm') {
      return '${(lengthInMeters * 100).toStringAsFixed(2)} cm';
    } else if (measurementUnit == 'inch') {
      final lengthInInches =
          lengthInMeters * 39.3701; // Convert meters to inches
      return '${lengthInInches.toStringAsFixed(2)} inch';
    }
    return '${(lengthInMeters * 100).toStringAsFixed(2)} cm'; // Default to cm
  }

  vector.Vector3 _getMiddleVector(vector.Vector3 A, vector.Vector3 B) {
    return vector.Vector3((A.x + B.x) / 2, (A.y + B.y) / 2, (A.z + B.z) / 2);
  }

  String _drawText(String text, vector.Vector3 position) {
    final textNodeName = 'text_${nodeNames.length}';
    final textGeometry = ARKitText(
      text: text,
      extrusionDepth: 1,
      materials: [
        ARKitMaterial(
          diffuse: ARKitMaterialProperty.color(Colors.red),
        ),
      ],
    );
    const scale = 0.001;
    final textNode = ARKitNode(
      geometry: textGeometry,
      position: position,
      scale: vector.Vector3(scale, scale, scale),
      name: textNodeName,
    );
    arkitController.add(textNode);
    nodeNames.add(textNodeName); // Track the node name
    return textNodeName; // Return the text node name
  }

  void _updateTextNode(
      String nodeName, String newText, vector.Vector3 position) {
    // Remove the existing text node
    arkitController.remove(nodeName);

    // Create a new text geometry with the updated content
    final updatedTextGeometry = ARKitText(
      text: newText,
      extrusionDepth: 1,
      materials: [
        ARKitMaterial(
          diffuse: ARKitMaterialProperty.color(Colors.red),
        ),
      ],
    );

    // Add the updated text node to the ARKit scene
    const scale = 0.001;
    final updatedTextNode = ARKitNode(
      geometry: updatedTextGeometry,
      position: position,
      scale: vector.Vector3(scale, scale, scale),
      name: nodeName,
    );
    arkitController.add(updatedTextNode); // Re-add the updated node
  }
}
