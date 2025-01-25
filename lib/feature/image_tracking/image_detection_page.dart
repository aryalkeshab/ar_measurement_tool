import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'image_detection_controller.dart';

class ImageDetectionPage extends StatelessWidget {
  final ImageDetectionController controller =
      Get.put(ImageDetectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Detection Sample')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          ARKitSceneView(
            detectionImagesGroupName: 'AR Resources',
            onARKitViewCreated: controller.onARKitViewCreated,
          ),
          Obx(() {
            return Stack(
              children: controller.detectedObjects.entries.map((entry) {
                final detectedObject = entry.value;
                return Positioned(
                  left:
                      detectedObject.screenPosition.dx - Random().nextInt(100),
                  top: detectedObject.screenPosition.dy,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Name: ${detectedObject.name}\n'
                      'Width: ${detectedObject.calculatedWidth.toStringAsFixed(2)} m\n'
                      'Height: ${detectedObject.calculatedHeight.toStringAsFixed(2)} m\n'
                      'Depth: ${detectedObject.depth.toStringAsFixed(2)} m',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }
}
