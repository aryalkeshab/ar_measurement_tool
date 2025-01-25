import 'dart:ui';

class DetectedObject {
  final String name;
  final double calculatedWidth;
  final double calculatedHeight;
  final double depth;
  final Offset screenPosition;

  DetectedObject({
    required this.name,
    required this.calculatedWidth,
    required this.calculatedHeight,
    required this.depth,
    required this.screenPosition,
  });

  DetectedObject copyWith({
    double? calculatedWidth,
    double? calculatedHeight,
    double? depth,
    Offset? screenPosition,
  }) {
    return DetectedObject(
      name: name,
      calculatedWidth: calculatedWidth ?? this.calculatedWidth,
      calculatedHeight: calculatedHeight ?? this.calculatedHeight,
      depth: depth ?? this.depth,
      screenPosition: screenPosition ?? this.screenPosition,
    );
  }
}
