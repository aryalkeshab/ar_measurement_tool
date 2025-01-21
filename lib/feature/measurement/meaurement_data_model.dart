import 'package:vector_math/vector_math_64.dart' as vector;

class MeasurementData {
  final vector.Vector3 startPosition;
  final vector.Vector3 endPosition;
  final String textNodeName;
  final vector.Vector3 textPosition;

  MeasurementData({
    required this.startPosition,
    required this.endPosition,
    required this.textNodeName,
    required this.textPosition,
  });
}
