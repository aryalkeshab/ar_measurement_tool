import 'package:ar_measurement_tool/feature/basic_object/basic_object_controller.dart';
import 'package:ar_measurement_tool/feature/home/home_screen.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:collection/collection.dart';

class Basic3DObjectPage extends StatelessWidget {
  static String routeName = "/basic-3d-object";

  const Basic3DObjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BasicObjectController());

    return GetBuilder<BasicObjectController>(builder: (c) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Basic 3D Object',
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
          actions: [
            // Dropdown for measurement units
            DropdownButton<String>(
              value: c.selectedObject,
              onChanged: (value) {
                if (value != null) {
                  c.updateSelectedObject(value);
                }
              },
              items: c.objects
                  .map((unit) => DropdownMenuItem(
                        value: unit,
                        child: Text(
                          unit.toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ))
                  .toList(),
              underline: const SizedBox(), // Removes default underline
              dropdownColor: Colors.grey, // Optional styling
              style: const TextStyle(color: Colors.white, fontSize: 16),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            ),
            // IconButton(
            //   onPressed: () {
            //     c.removeAllPreviousPositions();
            //     c.update();
            //   },
            //   icon: const Icon(
            //     Icons.replay_outlined,
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
        body: Builder(
          builder: (context) {
            return Stack(
              children: [
                ARKitSceneView(
                  enableTapRecognizer: true,
                  onARKitViewCreated: c.onARKitViewCreated,
                )
              ],
            );
          },
        ),
      );
    });
  }
}
