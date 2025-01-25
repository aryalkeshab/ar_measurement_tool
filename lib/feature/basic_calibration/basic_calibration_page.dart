import 'package:ar_measurement_tool/feature/home/home_screen.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import 'basic_calibration_controller.dart';

// class BasicCalibrationPage extends StatelessWidget {
//   static String routeName = "/basic_calibration";

//   const BasicCalibrationPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     Get.put(BasicCalibrationController());
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text('AR Calibration View'),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Get.offAllNamed(HomeScreen.routeName);
//           },
//         ),
//       ),
//       body: GetBuilder<BasicCalibrationController>(builder: (c) {
//         return Stack(
//           children: [
//             ARKitSceneView(
//               onARKitViewCreated: c.onARKitViewCreated,
//               showFeaturePoints: true,
//               planeDetection: ARPlaneDetection.horizontal,
//               configuration: ARKitConfiguration.worldTracking,
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
class BasicCalibrationPage extends StatelessWidget {
  static String routeName = "/basic_calibration";

  const BasicCalibrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BasicCalibrationController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('AR Calibration View'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.offAllNamed('/home');
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              Get.find<BasicCalibrationController>()
                  .changeMeasurementUnit(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'cm',
                child: Text('Centimeters (cm)'),
              ),
              const PopupMenuItem(
                value: 'inch',
                child: Text('Inches (inch)'),
              ),
            ],
          ),
        ],
      ),
      body: GetBuilder<BasicCalibrationController>(builder: (controller) {
        return Stack(
          children: [
            ARKitSceneView(
              onARKitViewCreated: controller.onARKitViewCreated,
              planeDetection: ARPlaneDetection.horizontal,
              showFeaturePoints: true,
              enableTapRecognizer: true,
              configuration: ARKitConfiguration.worldTracking,
            ),
          ],
        );
      }),
    );
  }
}

class ARCalibrationScreen extends StatefulWidget {
  const ARCalibrationScreen({Key? key}) : super(key: key);

  @override
  State<ARCalibrationScreen> createState() => _ARCalibrationScreenState();
}

class _ARCalibrationScreenState extends State<ARCalibrationScreen> {
  late ARKitController arkitController;
  String? anchorId;
  ARKitPlane? plane;
  ARKitNode? node;
  double objectScale = 1.0;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Calibration'),
      ),
      body: Stack(
        children: [
          ARKitSceneView(
            onARKitViewCreated: onARKitViewCreated,
            planeDetection: ARPlaneDetection.horizontal,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Adjust Object Scale',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Slider(
                  value: objectScale,
                  min: 0.1,
                  max: 2.0,
                  divisions: 19,
                  label: objectScale.toStringAsFixed(1),
                  onChanged: (value) {
                    setState(() {
                      objectScale = value;
                      updateReferenceObjectScale();
                    });
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  'Use the slider to match the size of the reference cube to a real-world object of the same size.',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onARKitViewCreated(ARKitController controller) {
    arkitController = controller;
    arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;
    addReferenceObject();
  }

  void addReferenceObject() {
    final referencePlane = ARKitPlane(
      width: 0.1,
      height: 0.1,
      materials: [
        ARKitMaterial(
          diffuse: ARKitMaterialProperty.color(Colors.blue),
        ),
      ],
    );

    plane = referencePlane;

    final referenceNode = ARKitNode(
      name: 'reference_object',
      geometry: referencePlane,
      position: vector.Vector3(0, 0, -0.5), // 50 cm in front of the camera
    );

    node = referenceNode;
    arkitController.add(referenceNode);
  }

  void _handleUpdateAnchor(ARKitAnchor anchor) {
    anchorId ??= anchor.identifier;

    if (anchor.identifier != anchorId) {
      return;
    }

    final planeAnchor = anchor as ARKitPlaneAnchor;
    setState(() {
      node?.position =
          vector.Vector3(planeAnchor.center.x, 0, planeAnchor.center.z);
      plane?.width.value = planeAnchor.extent.x;
      plane?.height.value = planeAnchor.extent.z;
    });

    print(
        'Node Position: ${node?.position.x}, ${node?.position.y}, ${node?.position.z}');
    print('Plane Dimensions: ${plane?.width.value}, ${plane?.height.value}');
  }

  void updateReferenceObjectScale() {
    if (node != null) {
      setState(() {
        node!.scale = vector.Vector3(objectScale, objectScale, objectScale);
      });
    }
  }
}
