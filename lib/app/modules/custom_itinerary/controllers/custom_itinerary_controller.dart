import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomItineraryController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();
  RxBool firstPhaseCompleted = false.obs;
  RxString notSelectedWithoutTransitTour = RxString('');
  RxList<String> tourValues = RxList<String>(<String>['']);

  RxString selectedTourWithoutTransit = RxString('');
}
