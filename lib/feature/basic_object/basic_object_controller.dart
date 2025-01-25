import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class BasicObjectController extends GetxController {
  late ARKitController arkitController;
  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    final cubeNode = ARKitNode(
      geometry: ARKitBox(
        width: 0.1, // Cube width in meters
        height: 0.1, // Cube height in meters
        length: 0.1, // Cube length in meters
        materials: [
          ARKitMaterial(
            diffuse: ARKitMaterialProperty.color(Colors.blue),
          )
        ],
      ),
      name: 'cube',
      position: vector.Vector3(
          0, 0, -0.5), // Place the cube 0.5 meters in front of the camera
    );

    arkitController.add(cubeNode);
    // arkitController.add(sphereNode);
    // arkitController.add(faceNode);
  }

  List<String> objects = [
    'cubeNode',
    'sphereNode',
    'faceNode',
    'None',
  ];
  String? selectedObject = 'cubeNode';

  void hideAll3DObjects() {
    arkitController.remove('cube');
    arkitController.remove('sphereNode');
    arkitController.remove('faceNode');

    update();
  }

  void updateSelectedObject(String? newSelectedObject) {
    selectedObject = newSelectedObject;
    if (selectedObject == "None") {
      hideAll3DObjects();
    } else if (selectedObject == "cubeNode") {
      hideAll3DObjects();
      arkitController.add(ARKitNode(
        geometry: ARKitBox(
          width: 0.1, // Cube width in meters
          height: 0.1, // Cube height in meters
          length: 0.1, // Cube length in meters
          materials: [
            ARKitMaterial(
              diffuse: ARKitMaterialProperty.color(Colors.blue),
            )
          ],
        ),
        name: 'cube',
        position: vector.Vector3(
            0, 0, -0.5), // Place the cube 0.5 meters in front of the camera
      ));
    } else if (selectedObject == "sphereNode") {
      hideAll3DObjects();
      arkitController.add(ARKitNode(
        geometry: ARKitSphere(
          radius: 0.1, // Sphere radius in meters
          materials: [
            ARKitMaterial(
              diffuse: ARKitMaterialProperty.color(Colors.red),
            )
          ],
        ),
        name: 'sphereNode',
        position: vector.Vector3(
            0, 0, -0.9), // Place the sphere 0.5 meters in front of the camera
      ));
    } else if (selectedObject == "faceNode") {
      hideAll3DObjects();
      arkitController.add(ARKitNode(
        geometry: ARKitFace(
          materials: [
            ARKitMaterial(
              diffuse: ARKitMaterialProperty.color(Colors.red),
            )
          ],
        ),
        name: 'faceNode',
        position: vector.Vector3(
            0, 0, -0.9), // Place the sphere 0.5 meters in front of the camera
      ));
    } else {
      hideAll3DObjects();
    }
    update();
  }
}
