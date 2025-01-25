import 'package:ar_measurement_tool/feature/basic_calibration/basic_calibration_controller.dart';
import 'package:ar_measurement_tool/feature/basic_calibration/basic_calibration_page.dart';
import 'package:ar_measurement_tool/feature/basic_object/basic_object.dart';
import 'package:ar_measurement_tool/feature/basic_object/basic_object_controller.dart';
import 'package:ar_measurement_tool/feature/home/home_screen.dart';
import 'package:ar_measurement_tool/feature/image_tracking/image_detection_controller.dart';
import 'package:ar_measurement_tool/feature/image_tracking/image_detection_page.dart';
import 'package:ar_measurement_tool/feature/measurement/measure_page.dart';
import 'package:ar_measurement_tool/feature/measurement/measurement_controller.dart';
import 'package:ar_measurement_tool/feature/object_detection/object_detection_screen.dart';
import 'package:get/get.dart';

final List<GetPage> pages = <GetPage>[
  GetPage(
    name: HomeScreen.routeName,
    page: () => HomeScreen(),
  ),
  GetPage(
    name: MeasurePage.routeName,
    page: () => MeasurePage(),
    binding: BindingsBuilder(
      () => Get.lazyPut(() => MeasurementController()),
    ),
  ),
  GetPage(
    name: Basic3DObjectPage.routeName,
    page: () => Basic3DObjectPage(),
    binding: BindingsBuilder(
      () => Get.lazyPut(() => BasicObjectController()),
    ),
  ),
  GetPage(
    name: BasicCalibrationPage.routeName,
    page: () => BasicCalibrationPage(),
    binding: BindingsBuilder(
      () => Get.lazyPut(() => BasicCalibrationController()),
    ),
  ),
  GetPage(
    name: ImageDetectionPage.routeName,
    page: () => ImageDetectionPage(),
    binding: BindingsBuilder(
      () => Get.lazyPut(() => ImageDetectionController()),
    ),
  ),
  GetPage(
    name: ObjectDetectionScreen.routeName,
    page: () => ObjectDetectionScreen(),
  ),
];
