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

  Map<String, dynamic> toJson() {
    return {
      'startPosition': _vectorToJson(startPosition),
      'endPosition': _vectorToJson(endPosition),
      'textNodeName': textNodeName,
      'textPosition': _vectorToJson(textPosition),
    };
  }

  // Helper method to convert Vector3 to a JSON-encodable format
  Map<String, double> _vectorToJson(vector.Vector3 vector) {
    return {
      'x': vector.x,
      'y': vector.y,
      'z': vector.z,
    };
  }

  // Factory constructor to deserialize from JSON
  factory MeasurementData.fromJson(Map<String, dynamic> json) {
    return MeasurementData(
      startPosition: _vectorFromJson(json['startPosition']),
      endPosition: _vectorFromJson(json['endPosition']),
      textNodeName: json['textNodeName'],
      textPosition: _vectorFromJson(json['textPosition']),
    );
  }

  // Helper method to convert JSON back to Vector3
  static vector.Vector3 _vectorFromJson(Map<String, dynamic> json) {
    return vector.Vector3(json['x'], json['y'], json['z']);
  }
}
