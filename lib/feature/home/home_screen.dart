import 'package:ar_measurement_tool/core/widgets/menu_items_widget.dart';
import 'package:ar_measurement_tool/feature/basic_calibration/basic_calibration_page.dart';
import 'package:ar_measurement_tool/feature/basic_object/basic_object.dart';
import 'package:ar_measurement_tool/feature/image_tracking/image_detection_page.dart';
import 'package:ar_measurement_tool/feature/measurement/measure_page.dart';
import 'package:ar_measurement_tool/feature/object_detection/object_detection_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Measurement Application',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            MenuItem(
              icon: Icons.calculate,
              title: 'Measurement Screen',
              subtitle:
                  'Select multiple points to detect distances in both inch and cm scale.',
              onTap: () => Get.toNamed(MeasurePage.routeName),
            ),
            const SizedBox(height: 10),
            MenuItem(
              icon: CupertinoIcons.cube_box_fill,
              title: 'Basic 3D Object',
              subtitle: 'Shows and hides different 3D objects in AR View.',
              onTap: () => Get.toNamed(Basic3DObjectPage.routeName),
            ),
            const SizedBox(height: 10),
            MenuItem(
              icon: CupertinoIcons.cube_box_fill,
              title: 'Image Detection in AR',
              subtitle:
                  'Detects a fish image and calculates its size in AR View.',
              onTap: () => Get.toNamed(ImageDetectionPage.routeName),
            ),
            const SizedBox(height: 10),
            MenuItem(
              icon: Icons.calculate_outlined,
              title: 'Basic Calibration',
              subtitle: 'Helps calibrate and scale virtual objects in AR View.',
              onTap: () => Get.toNamed(BasicCalibrationPage.routeName),
            ),
            const SizedBox(height: 10),
            MenuItem(
              icon: CupertinoIcons.cube_box_fill,
              title: 'Object Detection',
              subtitle: 'Object detection using the normal camera.',
              onTap: () => Get.toNamed(ObjectDetectionScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
