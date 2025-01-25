import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:ar_measurement_tool/feature/object_detection/models/recognition.dart';
import 'package:ar_measurement_tool/feature/object_detection/service/detector_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
// import 'package:camera/src/camera_image.dart' as image_lib;
import 'package:image/image.dart' as image_lib;

import 'package:vector_math/vector_math_64.dart' as vector;

class ARView extends StatefulWidget {
  final List<Recognition>? recognitions;

  const ARView({super.key, this.recognitions});

  @override
  State<ARView> createState() => _ARViewState();
}

class _ARViewState extends State<ARView> {
  late ARKitController arkitController;
  Timer? _imageFetchTimer;
  Detector? _detector;

  @override
  void initState() {
    super.initState();
    _initializeDetector();
  }

  Future<void> _initializeDetector() async {
    _detector = await Detector.start();
    _detector?.resultsStream.stream.listen((results) {
      if (results.containsKey('recognitions')) {
        _updateARScene(results['recognitions'] as List<Recognition>);
      }
    });
  }

  @override
  void dispose() {
    _imageFetchTimer?.cancel();
    arkitController.dispose();
    _detector?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AR Object Detection')),
      body: ARKitSceneView(
        onARKitViewCreated: onARKitViewCreated,
        planeDetection: ARPlaneDetection.horizontal,
      ),
    );
  }

  void onARKitViewCreated(ARKitController controller) {
    arkitController = controller;

    // Start the periodic fetching of ARKit images
    _imageFetchTimer =
        Timer.periodic(Duration(milliseconds: 100), (timer) async {
      await _fetchAndProcessImage();
    });
  }

  Future<void> _fetchAndProcessImage() async {
    try {
      // Fetch the image from ARKit
      final imageProvider = await arkitController.getCapturedImage();
      final byteData = await _getImageByteData(imageProvider);

      if (byteData != null) {
        final image = image_lib.decodeImage(byteData);
        if (image != null && _detector != null) {
          ImageConfiguration configuration = const ImageConfiguration();
          // _detector!.processFrame(
          // ); // Processing happens here
        }
      }
    } catch (e) {
      debugPrint("Error during image fetching or processing: $e");
    }
  }

  Future<Uint8List?> _getImageByteData(
      ImageProvider<Object> imageProvider) async {
    try {
      final completer = Completer<Uint8List>();
      final key = await imageProvider.obtainKey(const ImageConfiguration());
      final resolver = imageProvider.resolve(const ImageConfiguration());
      resolver.addListener(
        ImageStreamListener((info, _) async {
          final byteData =
              await info.image.toByteData(format: ImageByteFormat.rawRgba);
          completer.complete(byteData?.buffer.asUint8List());
        }),
      );
      return completer.future;
    } catch (e) {
      debugPrint("Error fetching byte data: $e");
      return null;
    }
  }

  void _updateARScene(List<Recognition> recognitions) {
    // arkitController.clear();

    for (var recognition in recognitions) {
      final position = getARPosition(recognition.renderLocation);

      // Add bounding box node
      final boxNode = ARKitNode(
        geometry: ARKitBox(
          width: recognition.renderLocation.width * 0.001,
          height: recognition.renderLocation.height * 0.001,
          length: 0.01,
          materials: [
            ARKitMaterial(
              diffuse: ARKitMaterialProperty.color(Colors.blue),
              transparency: 0.5,
            ),
          ],
        ),
        position: position,
      );

      // Add label node
      final textNode = ARKitNode(
        geometry: ARKitText(
          text: recognition.label,
          extrusionDepth: 1,
          materials: [
            ARKitMaterial(
              diffuse: ARKitMaterialProperty.color(Colors.red),
            ),
          ],
        ),
        position: position,
        scale: vector.Vector3(0.01, 0.01, 0.01),
      );

      arkitController.add(boxNode);
      arkitController.add(textNode);
    }
  }

  vector.Vector3 getARPosition(Rect renderLocation) {
    final x = (renderLocation.left + renderLocation.width / 2) * 0.001;
    final y = -(renderLocation.top + renderLocation.height / 2) * 0.001;
    final z = -0.5; // Fixed depth
    return vector.Vector3(x, y, z);
  }
}
