import 'package:ar_measurement_tool/core/route/pages.dart';
import 'package:ar_measurement_tool/feature/home/home_screen.dart';
import 'package:ar_measurement_tool/feature/measurement/measure_page.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure proper async setup

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 200),
      getPages: pages,
      initialRoute: HomeScreen.routeName,
    );
  }
}
