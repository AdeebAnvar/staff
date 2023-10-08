import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/theme/style.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_toast.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool showErrors = false.obs;
  RxString selectedBranch = ''.obs;
  Rx<Color?> branchColor = telecallerBlue.obs;
  GetStorage storage = GetStorage();
  final RxString emailError = RxString('');
  final RxString passwordError = RxString('');
  Rx<String>? email;
  Rx<String>? password;
  Rx<bool> isPassword = true.obs;
  Rx<bool> isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    selectedBranch.value = storage.read('branchName') ?? 'no branch';
    log('fgrwgv ${selectedBranch.value}');
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  String? validateEmail(String? value) {
    if (GetUtils.isLengthLessOrEqual(value, 3)) {
      emailError.value = 'Enter a valid userName';
      return emailError.value;
    } else {
      return null;
    }
  }

  String? validatePassWord(String? value) =>
      GetUtils.isLengthGreaterThan(value, 4) ? null : 'Enter valid password';

  Future<void> onClickLogin() async {
    isLoading.value = true;

    if (emailController.text.length <= 3 &&
        passwordController.text.length <= 3) {
      emailError.value = 'please provide a valid userName';
      passwordError.value = 'please provide a valid password';

      isLoading.value = false;
    } else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        final User? user = FirebaseAuth.instance.currentUser;
        final String? toke = await user!.getIdToken(true);
        await storage.write('token', toke);
        log(toke.toString());
        Get.offAllNamed(Routes.HOME);
        emailError.value = '';
        passwordError.value = '';
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emailError.value = '';
          passwordError.value = '';
          CustomToastMessage().showCustomToastMessage('No User In This email');
          log('Nofound for that email.');
          isLoading.value = false;
        } else if (e.code == 'wrong-password') {
          emailError.value = '';
          passwordError.value = '';
          Fluttertoast.showToast(
              msg: 'Password is wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.blueAccent,
              textColor: Colors.white,
              fontSize: 16.0);
          log('Wrong password provided for that user.');
          isLoading.value = false;
        }
      }
    }
  }

  Future<void> onClickTourMaker() async {
    selectedBranch.value = 'Tour Maker';
  }

  Future<void> onClickTrippens() async {
    selectedBranch.value = 'Trippens';
    await storage.remove('branchName');
    await storage.write('branchName', 'Trippens');
    final dynamic gitj = await storage.read('branchName');
    log('fgrwgv $gitj');
  }

  Future<void> onClickAyra() async {
    selectedBranch.value = 'Ayra';
    await storage.remove('branchName');
    await storage.write('branchName', 'Ayra');
  }
}
