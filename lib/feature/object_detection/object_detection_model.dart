// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'dart:typed_data';
// import 'dart:io';
// import 'package:flutter/services.dart';

// class ObjectDetectionModel {
//   Interpreter? _interpreter;
//   late List<String> _labels;

//   // Load TFLite model
//   Future<void> loadModel() async {
//     try {
//       // Load the TFLite model
//       final interpreterOptions = InterpreterOptions()
//         ..threads = 4; // Adjust threads based on your need
//       _interpreter = await Interpreter.fromAsset('assets/yolov8n_int8.tflite',
//           options: interpreterOptions);

//       // Load the labels from the metaData.yaml file
//       _labels = await _loadLabels();
//     } catch (e) {
//       print("Error loading model: $e");
//     }
//   }

//   // Function to load the labels (from metaData.yaml or a separate file)
//   Future<List<String>> _loadLabels() async {
//     // Load your labels either from assets or hardcode them
//     // You can extract the label names from your `metaData.yaml` file
//     return [
//       "person",
//       "bicycle",
//       "car",
//       "motorcycle",
//       "airplane",
//       "bus",
//       "train",
//       "truck",
//       "boat",
//       "traffic light",
//       "fire hydrant",
//       "stop sign",
//       "parking meter",
//       "bench",
//       "bird",
//       "cat",
//       "dog",
//       "horse",
//       "sheep",
//       "cow",
//       "elephant",
//       "bear",
//       "zebra",
//       "giraffe",
//       "backpack",
//       "umbrella",
//       "handbag",
//       "tie",
//       "suitcase",
//       "frisbee",
//       "skis",
//       "snowboard",
//       "sports ball",
//       "kite",
//       "baseball bat",
//       "baseball glove",
//       "skateboard",
//       "surfboard",
//       "tennis racket",
//       "bottle",
//       "wine glass",
//       "cup",
//       "fork",
//       "knife",
//       "spoon",
//       "bowl",
//       "banana",
//       "apple",
//       "sandwich",
//       "orange",
//       "broccoli",
//       "carrot",
//       "hot dog",
//       "pizza",
//       "donut",
//       "cake",
//       "chair",
//       "couch",
//       "potted plant",
//       "bed",
//       "dining table",
//       "toilet",
//       "tv",
//       "laptop",
//       "mouse",
//       "remote",
//       "keyboard",
//       "cell phone",
//       "microwave",
//       "oven",
//       "toaster",
//       "sink",
//       "refrigerator",
//       "book",
//       "clock",
//       "vase",
//       "scissors",
//       "teddy bear",
//       "hair drier",
//       "toothbrush"
//     ];
//   }

//   // Run detection on input image
//   // Future<List<Recognition>> runModel(Uint8List imageBytes) async {
//   //   var input = imageBytes;
//   //   var output = List.generate(1, (index) => List.filled(10, 0.0));

//   //   _interpreter!.run(input, output);

//   //   // Parse output into bounding boxes and class labels
//   //   return _parseOutput(output);
//   // }

//   Future<List<Recognition>> runModel(Uint8List imageBytes) async {
//     var input = imageBytes;
//     var output = List.generate(
//         1,
//         (index) =>
//             List.filled(10, 0.0)); // Example: adjust size to match model output

//     _interpreter!.run(input, output);

//     // Parse output into bounding boxes and class labels
//     return _parseOutput(output);
//   }

//   // Parse raw model output
//   List<Recognition> _parseOutput(List output) {
//     List<Recognition> recognitions = [];

//     // Example parsing logic (you may need to adjust based on the model's actual output format)
//     for (var detection in output[0]) {
//       double confidence = detection[0];
//       int classId = detection[1].toInt();
//       double left = detection[2];
//       double top = detection[3];
//       double right = detection[4];
//       double bottom = detection[5];

//       // Only add recognitions that are sufficiently confident
//       if (confidence > 0.5) {
//         recognitions.add(Recognition(
//           label: _labels[classId],
//           confidence: confidence,
//           left: left,
//           top: top,
//           right: right,
//           bottom: bottom,
//         ));
//       }
//     }

//     return recognitions;
//   }
// }

// class Recognition {
//   final String label;
//   final double confidence;
//   final double left;
//   final double top;
//   final double right;
//   final double bottom;

//   Recognition({
//     required this.label,
//     required this.confidence,
//     required this.left,
//     required this.top,
//     required this.right,
//     required this.bottom,
//   });
// }
