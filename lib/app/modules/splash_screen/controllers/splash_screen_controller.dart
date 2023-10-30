import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../routes/app_pages.dart';
import '../views/splash_screen_view.dart';

class SplashScreenController extends GetxController
    with StateMixin<SplashScreenView> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Rx<bool> isInternetConnect = true.obs;
  GetStorage storage = GetStorage();
  @override
  Future<void> onInit() async {
    super.onInit();
    await checkUserExistsOrNot();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  Future<void> checkUserExistsOrNot() async {
    isInternetConnect.value = await InternetConnectionChecker().hasConnection;
    if (!isInternetConnect.value) {
      Get.offAllNamed(Routes.NO_INTERNET);
    } else {
      try {
        final User? currentUser = auth.currentUser;
        log(currentUser.toString());
        if (currentUser != null) {
          try {
            final String? token = await currentUser.getIdToken(true);
            await storage.write('token', token);
            log('in splash $token');
            Get.offAllNamed(Routes.HOME);
          } catch (e) {
            // Handle other authentication-related errors if necessary
            log('Error getting ID token: $e');
            await auth.signOut();
            // You can handle this error differently if needed
            Get.offAllNamed(Routes.LOGIN);
          }
        } else {
          // Check if the user has linked to another authentication provider
          // and handle the error accordingly
          FirebaseAuthException? authException;
          try {
            await auth.signOut();
          } catch (e) {
            if (e is FirebaseAuthException) {
              authException = e;
            }
          }

          if (authException != null &&
              authException.code == 'no-such-provider') {
            // Handle the case where the user is not linked to the provider
            // Redirect the user to the provider linking screen or take appropriate action
            log('User not linked to the provider: $authException');
            // You can handle this error differently if needed
          } else {
            // Handle other errors
            log('Error checking user: ');
            // You can handle this error differently if needed
            Get.offAllNamed(Routes.LOGIN);
          }
        }
      } catch (e) {
        log('Error checking user: $e');
        // Handle other errors
        // You can handle this error differently if needed
        Get.offAllNamed(Routes.LOGIN);
      }
    }
  }
}
