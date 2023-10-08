import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textformfield.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        leading: PopupMenuButton<dynamic>(
          elevation: 4,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          itemBuilder: (BuildContext context) => <PopupMenuItem<dynamic>>[
            PopupMenuItem<dynamic>(
              onTap: () => controller.onClickTrippens(),
              textStyle: subheading2,
              value: 'Trippens',
              child: const Text('Trippens'),
            ),
            PopupMenuItem<dynamic>(
              onTap: () => controller.onClickTourMaker(),
              textStyle: subheading2,
              value: 'TourMaker',
              child: const Text('TourMaker'),
            ),
            PopupMenuItem<dynamic>(
              onTap: () => controller.onClickAyra(),
              textStyle: subheading2,
              value: 'Ayra',
              child: const Text('Ayra'),
            ),
          ],
        ),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 130, horizontal: 5),
          children: <Widget>[
            SizedBox(height: 10.h),
            Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                width: 220,
                height: 160,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //
                    Text(
                      'Welcome !',
                      style: TextStyle(
                        fontFamily: 'enigma',
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                        color: controller.selectedBranch.value == 'Trippens'
                            ? telecallerRed
                            : controller.selectedBranch.value == 'Tour Maker'
                                ? englishViolet
                                : controller.selectedBranch.value == 'Ayra'
                                    ? const Color(0xFF651fff)
                                    : telecallerBlue,
                      ),
                    ),
                    Text(
                      'Login to your account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: controller.selectedBranch.value == 'Trippens'
                            ? telecallerRed
                            : controller.selectedBranch.value == 'Tour Maker'
                                ? englishViolet
                                : controller.selectedBranch.value == 'Ayra'
                                    ? const Color(0xFF651fff)
                                    : telecallerBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Form(
              key: controller.formKey,
              child: Column(
                children: <Widget>[
                  Obx(
                    () {
                      return CustomWhiteTextFormField(
                        errorTextColor: telecallerRed,
                        controller: controller.emailController,
                        onChanged: (String value) =>
                            controller.email?.value = value,
                        hintText: 'Email',
                        errorText: controller.emailError.value,
                      );
                    },
                  ),
                  Obx(
                    () {
                      return CustomWhiteTextFormField(
                        errorTextColor: telecallerRed,
                        controller: controller.passwordController,
                        isPassword: true,
                        onChanged: (String value) =>
                            controller.password?.value = value,
                        hintText: 'Password',
                        errorText: controller.passwordError.value,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Obx(
                () {
                  return CustomButton().showBlueButton(
                    label: 'Login',
                    color: controller.selectedBranch.value == 'Trippens'
                        ? telecallerRed
                        : controller.selectedBranch.value == 'Tour Maker'
                            ? englishViolet
                            : controller.selectedBranch.value == 'Ayra'
                                ? const Color(0xFF651fff)
                                : telecallerBlue,
                    onTap: () => controller.onClickLogin(),
                    isLoading: controller.isLoading.value,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
