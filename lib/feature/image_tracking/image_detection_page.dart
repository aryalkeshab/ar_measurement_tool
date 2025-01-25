import 'dart:math';

import 'package:ar_measurement_tool/feature/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'image_detection_controller.dart';

class ImageDetectionPage extends StatelessWidget {
  static const String routeName = "/image-detection";

  final ImageDetectionController controller =
      Get.put(ImageDetectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Image Detection And Calibration Sample',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.offAllNamed(HomeScreen.routeName);
          },
        ),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          ARKitSceneView(
            detectionImagesGroupName: 'AR Resources',
            onARKitViewCreated: controller.onARKitViewCreated,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Obx(() {
              // Check if any object is detected
              if (controller.detectedObjects.isEmpty) {
                return const Text(
                  "No objects detected.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    backgroundColor: Colors.black54,
                  ),
                );
              }

              // Get the first detected object
              final detectedObject = controller.detectedObjects.values.first;

              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Name: ${detectedObject.name}",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      "Width: ${detectedObject.calculatedWidth.toStringAsFixed(2)} meters",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      "Height: ${detectedObject.calculatedHeight.toStringAsFixed(2)} meters",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      "Depth: ${detectedObject.depth.toStringAsFixed(2)} meters",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
