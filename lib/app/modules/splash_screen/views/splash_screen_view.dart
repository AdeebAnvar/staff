import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/custom_loading_screen.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    return const Scaffold(
      body: CustomLoadingScreen(),
    );
  }
}
