import 'package:ar_measurement_tool/feature/image_tracking/detected_object_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'dart:math';
import 'package:vector_math/vector_math_64.dart' as vector;

class ImageDetectionController extends GetxController {
  late ARKitController arkitController;

  final RxMap<String, DetectedObject> detectedObjects =
      <String, DetectedObject>{}.obs;

  @override
  void onClose() {
    arkitController.dispose();
    super.onClose();
  }

  void onARKitViewCreated(ARKitController controller) {
    arkitController = controller;

    arkitController.add(ARKitNode(
      geometry: ARKitSphere(
        radius: 0.05,
        materials: [
          ARKitMaterial(
            diffuse: ARKitMaterialProperty.color(Colors.red),
          )
        ],
      ),
      name: 'sphereNode',
      position: vector.Vector3(0, 0, -0.9),
    ));

    arkitController.onNodeTap = (nodes) => onNodeTapHandler(nodes);
    arkitController.onAddNodeForAnchor = onAnchorWasFound;
    arkitController.onUpdateNodeForAnchor = onAnchorUpdated;
  }

  void onNodeTapHandler(List<String> nodes) {
    print('Nodes tapped: ${nodes.length}');
  }

  void onAnchorWasFound(ARKitAnchor anchor) {
    if (anchor is ARKitImageAnchor) {
      _addOrUpdateDetectedObject(anchor);
    }
  }

  void onAnchorUpdated(ARKitAnchor anchor) {
    if (anchor is ARKitImageAnchor) {
      _addOrUpdateDetectedObject(anchor);
    }
  }

  void _addOrUpdateDetectedObject(ARKitImageAnchor anchor) {
    final position = anchor.transform.getColumn(3);
    final screenPosition = _calculateScreenPosition(position);

    final nodeName = 'border_${anchor.referenceImageName}';

    if (detectedObjects.containsKey(anchor.identifier)) {
      detectedObjects[anchor.identifier] =
          detectedObjects[anchor.identifier]!.copyWith(
        calculatedWidth: anchor.referenceImagePhysicalSize.x,
        calculatedHeight: anchor.referenceImagePhysicalSize.y,
        depth: position.z.abs(),
        screenPosition: screenPosition,
      );

      final updatedBorderNodes = _createBorder(
        vector.Vector3(position.x, position.y, position.z),
        anchor.referenceImagePhysicalSize.x,
        anchor.referenceImagePhysicalSize.y,
        0.0009,
      );

      for (final node in updatedBorderNodes) {
        arkitController.update(node.name, node: node);
      }
    } else {
      detectedObjects[anchor.identifier] = DetectedObject(
        name: anchor.referenceImageName ?? 'Unknown',
        calculatedWidth: anchor.referenceImagePhysicalSize.x,
        calculatedHeight: anchor.referenceImagePhysicalSize.y,
        depth: position.z.abs(),
        screenPosition: screenPosition,
      );

      final newBorderNodes = _createBorder(
        vector.Vector3(position.x, position.y, position.z),
        anchor.referenceImagePhysicalSize.x,
        anchor.referenceImagePhysicalSize.y,
        0.0009,
      );

      for (final node in newBorderNodes) {
        arkitController.add(node);
      }
    }
  }

  Offset _calculateScreenPosition(vector.Vector4 position) {
    return Offset(100, 100); // Replace with actual logic.
  }

  List<ARKitNode> _createBorder(
      vector.Vector3 position, double width, double height, double thickness) {
    final List<ARKitNode> borderNodes = [];

    final material = ARKitMaterial(
      diffuse: ARKitMaterialProperty.color(Colors.red),
    );

    // Top border
    borderNodes.add(
      ARKitNode(
        geometry: ARKitBox(
          width: width,
          height: thickness,
          length: thickness,
          materials: [material],
        ),
        position:
            vector.Vector3(position.x, position.y + height / 2, position.z),
      ),
    );

    // Bottom border
    borderNodes.add(
      ARKitNode(
        geometry: ARKitBox(
          width: width,
          height: thickness,
          length: thickness,
          materials: [material],
        ),
        position:
            vector.Vector3(position.x, position.y - height / 2, position.z),
      ),
    );

    // Left border
    borderNodes.add(
      ARKitNode(
        geometry: ARKitBox(
          width: thickness,
          height: height,
          length: thickness,
          materials: [material],
        ),
        position:
            vector.Vector3(position.x - width / 2, position.y, position.z),
      ),
    );

    // Right border
    borderNodes.add(
      ARKitNode(
        geometry: ARKitBox(
          width: thickness,
          height: height,
          length: thickness,
          materials: [material],
        ),
        position:
            vector.Vector3(position.x + width / 2, position.y, position.z),
      ),
    );

    return borderNodes;
  }
}
