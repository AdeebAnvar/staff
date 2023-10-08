import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/constants.dart';
import '../../../widgets/custom_loading_screen.dart';
import '../../screens/field_staff_home.dart';
import '../../screens/telecaller_home.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: controller.obx(
          onLoading: const CustomLoadingScreen(),
          (HomeView? state) =>
              controller.telecallerData[0].userType != 'telecaller'
                  ? FieldStaffHomeScreen(homeController: controller)
                  : TelecallerHomeScreen(homeController: controller)),
    );
  }

  GestureDetector buildTile(
      {IconData? icon, String? label, String? count, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: AnimatedBuilder(
            animation: controller.animation,
            builder: (BuildContext context, Widget? child) {
              return Transform.scale(
                scale: controller.animation.value,
                child: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        icon,
                        color: getColorFromHex(depColor),
                      ),
                      Text(
                        label ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        count ?? '',
                        style: TextStyle(
                          color: getColorFromHex(depColor),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
