import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/utils/constants.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_empty_screen.dart';
import '../controllers/no_internet_controller.dart';

class NoInternetView extends GetView<NoInternetController> {
  const NoInternetView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(NoInternetController());
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomEmptyScreen(label: 'Network Problem !'),
          const SizedBox(height: 50),
          CustomButton().showBlueButton(
              onTap: () {
                Get.offAllNamed(Routes.SPLASH_SCREEN);
              },
              isLoading: false,
              label: 'Retry',
              color: getColorFromHex(depColor)!)
        ],
      ),
    ));
  }
}
