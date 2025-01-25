import 'package:ar_measurement_tool/feature/basic_calibration/basic_calibration_page.dart';
import 'package:ar_measurement_tool/feature/basic_object/basic_object.dart';
import 'package:ar_measurement_tool/feature/googleml/object_detector_view.dart';
import 'package:ar_measurement_tool/feature/image_tracking/image_detection_page.dart';
import 'package:ar_measurement_tool/feature/measurement/measure_page.dart';
import 'package:ar_measurement_tool/feature/object_detection/ui/detector_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Measurement Application',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.calculate,
              size: 30,
            ),
            title: const Text(
              'Measurement Screen',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            onTap: () {
              Get.toNamed(MeasurePage.routeName);
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.cube_box_fill,
              size: 30,
            ),
            title: const Text(
              'Basic 3D Object',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            onTap: () {
              Get.toNamed(Basic3DObjectPage.routeName);
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.calculate_outlined,
              size: 30,
            ),
            title: const Text(
              'Basic Calibration',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            onTap: () {
              Get.toNamed(
                BasicCalibrationPage.routeName,
              );
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.cube_box_fill,
              size: 30,
            ),
            title: const Text(
              'Object Detection',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            onTap: () {
              Get.toNamed(ObjectDetectorView.routeName);
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.cube_box_fill,
              size: 30,
            ),
            title: const Text(
              'Tflite detection',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            onTap: () {
              // Get.to(() => (ARWithTFLitePage));
              Get.to(() => ObjectDetectionScreen());
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.cube_box_fill,
              size: 30,
            ),
            title: const Text(
              'Image Detection in AR',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            onTap: () {
              // Get.to(() => (ARWithTFLitePage));
              Get.to(() => ImageDetectionPage());
            },
          ),
          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

class ARWithTFLitePage {}
