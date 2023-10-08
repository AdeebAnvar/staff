// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../data/models/network_models/single_leads_model.dart';
import '../../../data/models/network_models/tours_model.dart';
import '../../../data/repository/network_repo/leads_repository.dart';
import '../../../data/repository/network_repo/tours_repository.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio_client.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/custom_toast.dart';
import '../views/single_lead_view.dart';

class SingleLeadController extends GetxController
    with StateMixin<SingleLeadView> {
  RxList<String> dropdownValues = RxList<String>(<String>['']);
  RxString selectedTourCode = RxString('');
  RxList<TourModel> toursData = <TourModel>[].obs;
  String? depID;
  GetStorage storage = GetStorage();
  String? customerName;
  String? vehicle;
  String? pax;
  RxString selectedCategory = RxString('');
  String? remarks;
  String tourCode = '';
  GlobalKey<FormState> formKey = GlobalKey();
  RxBool responseClicked = false.obs;
  File? audioFile;
  RxBool viewFollowupsClicked = false.obs;
  RxBool isloading = false.obs;
  RxBool updatingCustomer = false.obs;
  RxBool recordedCallAdded = false.obs;
  RxBool completedResponse = false.obs;
  Rx<String> selectedDate = ''.obs;
  Rx<String> selectedFollowUpDate = ''.obs;
  Rx<String> response = ''.obs;
  Rx<String> selectedProgress = progress[0].obs;
  String? leadId;
  RxBool isLoading = false.obs;
  RxString errorText = ''.obs;
  RxString audiofileErrorText = ''.obs;
  List<SingleLeadModel> leads = <SingleLeadModel>[].obs;
  String? branchId;
  @override
  Future<void> onInit() async {
    super.onInit();

    log('message');
    await loadData();
  }

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      leadId = Get.arguments as String;
      branchId = await storage.read('branchID') as String;
      await loadLeadData(leadId.toString());
      depID = await storage.read('depID') as String;
      await loadTour();
      change(null, status: RxStatus.success());
    }
  }

  void onClickBooking() {
    Get.toNamed(Routes.BOOKING_SCREEN, arguments: <dynamic>[
      leads[0].customerName,
      leads[0].customerId,
      leads[0].customerPhone
    ]);
  }

  void onCickResponse() {
    responseClicked.value = true;
  }

  Future<void> onClickUpdateResponse() async {
    isloading.value = true;
    if (formKey.currentState!.validate()) {
      audiofileErrorText.value = '';
      if (selectedProgress.value != 'Select Progress') {
        log('knukunu 3');
        audiofileErrorText.value = '';

        if (selectedProgress.value != 'Not Answering' &&
            selectedProgress.value != 'Waste') {
          log('knukunu 4');
          audiofileErrorText.value = '';

          if (audioFile != null) {
            log('knukunu 5');
            audiofileErrorText.value = '';
            String formattedDateTimeString = '';
            if (selectedFollowUpDate != null &&
                selectedFollowUpDate.isNotEmpty) {
              final DateTime originalDateTime =
                  DateTime.parse(selectedFollowUpDate.value);
              final DateFormat desiredFormat =
                  DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
              formattedDateTimeString = desiredFormat.format(originalDateTime);
            }
            addResPonse(
              selectedFollowUpDate: formattedDateTimeString,
              selectedProgress: selectedProgress.value,
              response: response.value,
            );
          } else {
            log('knukunu 6');
            isloading.value = false;

            audiofileErrorText.value = 'Add the recorded Call';
          }
        } else {
          log('knukunu 7');
          audiofileErrorText.value = '';
          String formattedDateTimeString = '';
          if (selectedFollowUpDate != null && selectedFollowUpDate.isNotEmpty) {
            final DateTime originalDateTime =
                DateTime.parse(selectedFollowUpDate.value);
            final DateFormat desiredFormat =
                DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
            formattedDateTimeString = desiredFormat.format(originalDateTime);
          }

          addResPonse(
            selectedFollowUpDate: formattedDateTimeString,
            selectedProgress: selectedProgress.value,
            response: response.value,
          );
        }
      } else {
        log('knukunu 8');
        isloading.value = false;

        audiofileErrorText.value = '';

        CustomToastMessage().showCustomToastMessage('Select Progress');
      }
    } else {
      log('knukunu 9');
      isloading.value = false;
    }
  }

  Future<void> onCallClicked() async {
    final String? number = leads[0].customerPhone;
    await FlutterPhoneDirectCaller.callNumber(number.toString());
  }

  String? validateResponse(String? value) =>
      GetUtils.isLengthLessOrEqual(value, 10) ? 'Add response' : null;
  String? validateFollowUpDate(String? value) =>
      DateTime.tryParse(value ?? '') != null ? null : 'add date';
  String? validateDate(String? value) =>
      DateTime.tryParse(value ?? '') != null ? null : 'add Followup date';

  Future<void> addResPonse(
      {required String selectedFollowUpDate,
      required String selectedProgress,
      required String response}) async {
    try {
      if (selectedProgress != 'Not Answering' && selectedProgress != 'Waste') {
        if (selectedFollowUpDate != null && selectedFollowUpDate.isNotEmpty) {
          await LeadsRepository()
              .addFollowUpResponseWithAudio(
                  customerProgress: selectedProgress,
                  responseText: response,
                  followUpDate:
                      DateTime.parse(selectedFollowUpDate).toIso8601String(),
                  customeID: leads[0].customerId.toString(),
                  leadID: leads[0].leadId,
                  audioName: audioFile?.path.split('/').last,
                  audioPath: audioFile?.path)
              .then((ApiResponse<Map<String, dynamic>> res) {
            if (res.status == ApiResponseStatus.completed) {
              responseClicked.value = false;
              isloading.value = false;

              Get.back();
            } else {
              isloading.value = false;
              CustomToastMessage()
                  .showCustomToastMessage("Response didn't added");
            }
          });
        } else {
          await LeadsRepository()
              .addNormalResponseWithAudio(
                  customerProgress: selectedProgress,
                  responseText: response,
                  customeID: leads[0].customerId.toString(),
                  leadID: leads[0].leadId,
                  audioName: audioFile?.path.split('/').last,
                  audioPath: audioFile?.path)
              .then((ApiResponse<Map<String, dynamic>> res) {
            if (res.status == ApiResponseStatus.completed) {
              responseClicked.value = false;
              isloading.value = false;

              Get.back();
            } else {
              isloading.value = false;
              CustomToastMessage()
                  .showCustomToastMessage("Response didn't added");
            }
          });
        }
      } else {
        if (selectedFollowUpDate != null && selectedFollowUpDate.isNotEmpty) {
          await LeadsRepository()
              .addFollowUpResponseWithoutAudio(
            customerProgress: selectedProgress,
            responseText: response,
            followUpDate:
                DateTime.parse(selectedFollowUpDate).toIso8601String(),
            customeID: leads[0].customerId.toString(),
            leadID: leads[0].leadId,
          )
              .then((ApiResponse<Map<String, dynamic>> res) {
            if (res.status == ApiResponseStatus.completed) {
              responseClicked.value = false;
              isloading.value = false;

              Get.back();
            } else {
              isloading.value = false;
              CustomToastMessage()
                  .showCustomToastMessage("Response didn't added");
            }
          });
        } else {
          await LeadsRepository()
              .addNormalResponseWithoutAudio(
            customerProgress: selectedProgress,
            responseText: response,
            customeID: leads[0].customerId.toString(),
            leadID: leads[0].leadId,
          )
              .then((ApiResponse<Map<String, dynamic>> res) {
            if (res.status == ApiResponseStatus.completed) {
              responseClicked.value = false;
              isloading.value = false;

              Get.back();
            } else {
              isloading.value = false;
              CustomToastMessage()
                  .showCustomToastMessage("Response didn't added");
            }
          });
        }
      }
    } catch (e) {
      isloading.value = false;

      log('iubugbuigb ${e.toString()}');
    }
  }

  Future<void> loadLeadData(String id) async {
    try {
      final ApiResponse<List<SingleLeadModel>> response =
          await LeadsRepository().getSingleLead(id);
      log('fucked jkjk${response.message}');
      if (response.status == ApiResponseStatus.completed) {
        leads = response.data!;
        log('vgbhnjkm ${leads[0].assigned}');
        selectedTourCode.value = leads[0].tourCode.toString();
        selectedCategory.value = leads[0].customerCategory.toString();
        log(selectedTourCode.value);
      } else {
        change(null, status: RxStatus.empty());
      }
    } catch (e) {
      log('khuiuh8uiu ${e.toString()}');
    }
  }

  Future<void> loadTour() async {
    try {
      final ApiResponse<List<TourModel>> response =
          await ToursRepository().getAllToursInDepartment(depID.toString());
      log(response.message.toString());
      if (response.data != null && response.data!.isNotEmpty) {
        toursData.value = response.data!;
        dropdownValues.clear();
        final Set<String> uniqueValues =
            <String>{}; // Use a set to track unique values
        uniqueValues.clear();

        for (final TourModel tour in toursData) {
          if (tour.tourCode != null && !uniqueValues.contains(tour.tourCode)) {
            uniqueValues.add(tour.tourName!);
            dropdownValues.add(tour.tourName!);
          } else {
            // Debug statement for duplicate value
            log('Duplicate tourCode found: ${tour.tourCode}');
          }
        }
        if (selectedTourCode.value != 'Not Specified' &&
            selectedTourCode.value != 'Not specified' &&
            selectedTourCode.value != 'not Specified' &&
            selectedTourCode.value != 'undefined') {
          tourCode = toursData
              .firstWhere((TourModel element) =>
                  element.tourName == selectedTourCode.value)
              .tourCode
              .toString();
        }

        change(null, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } catch (e) {
      log('rfruiooik ${e.toString()}');
      change(null, status: RxStatus.empty());
    }
  }

  Future<void> onMessageClicked() async {
    try {
      final Uri uri = Uri(
          scheme: 'sms',
          path: leads[0].customerPhone,
          queryParameters: <String, dynamic>{'body': 'hi'});
      if (await canLaunch(uri.toString())) {
        await launch(uri.toString());
      } else {
        log('message');
      }
    } catch (e) {
      log('weyijkcaa ${e.toString()}');
    }
  }

  Future<void> fetchAudioRecorder() async {
    isLoading.value = true;
    //try{
    final PermissionStatus status =
        await Permission.manageExternalStorage.request();
    if (status.isDenied || status.isPermanentlyDenied || status.isRestricted) {
      throw 'Please allow storage permission to upload files';
    } else {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        onFileLoading: (FilePickerStatus p0) {
          log('frg $p0');
        },
        type: FileType.audio, // Specify the file type as audio
      );

      if (result != null && result.files.isNotEmpty) {
        audioFile = File(result.files.first.path!);
        recordedCallAdded.value = true;
      }
    }
    // } catch (e) {
    //   log(e.toString());
    // }
    isLoading.value = false;
  }

  // Future<void> fetchAudioRecorder() async {
  //   final PermissionStatus status = await Permission.storage.request();
  //   if (status.isGranted) {
  //     // Permission is granted, you can now access external storage.
  //     log('Permission is granted, you can now access external storage.');
  //     final FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       onFileLoading: (FilePickerStatus status) {
  //         if (status.toString().contains('FilePickerStatus.done')) {
  //           log('Called');
  //           // return Get.back();
  //         }

  //         log(status.toString());
  //       },
  //       type: FileType.audio,
  //     );

  //     if (result == null) {
  //       log('No audio file selected');
  //     } else {
  //       audioFile = result.files.first;

  //       if (audioFile != null) {
  //         // Get.back();
  //       }
  //     }
  //   } else if (status.isDenied) {
  //     if (await Permission.storage.shouldShowRequestRationale) {
  //       // Explain to the user why the permission is needed and request again.
  //       log('Permission is denied, please grant access to external storage.');
  //     } else {
  //       // The user denied permission without asking for an explanation.
  //       log('Permission is denied, handle this case appropriately (show a message, etc.).');

  //       // Show a message to the user informing them about the denied permission.
  //       // You can use a dialog, toast, or any other UI element to display the message.
  //     }
  //   }
  // }

  void onClickResponseHistory(String id) =>
      Get.toNamed(Routes.RESPONSES_SCREEN, arguments: id);

  Future<void> onClickEditCustomerDetails() async {
    Get.bottomSheet(
      isScrollControlled: true,
      Padding(
        padding: const EdgeInsets.all(24),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: <Widget>[
                buildItem('Customer ID', leads[0].customerId.toString()),
                buildEditableTextField(
                    label: 'Name',
                    initialValue: leads[0].customerName.toString(),
                    keyBoardType: TextInputType.name,
                    onChanged: (String p0) => customerName = p0,
                    validator: (String? p0) {
                      return null;
                    }),
                Obx(() {
                  return CustomDropDownButton(
                    dropdownValues: dropdownValues,
                    value: selectedTourCode.value != null &&
                            selectedTourCode.value.isNotEmpty &&
                            selectedTourCode.value != 'Not specified' &&
                            selectedTourCode.value != 'undefined'
                        ? selectedTourCode.value
                        : null,
                    onChanged: (String? p0) {
                      selectedTourCode.value = p0.toString();
                      log(selectedTourCode.value);
                    },
                    labelText: 'Select Tour',
                    errorText: '',
                  );
                }),
                buildItem(
                    'created date',
                    leads[0]
                        .createdAt
                        .toString()
                        .parseFromIsoDate()
                        .toDateTime()),
                const SizedBox(height: 10),
                buildEditableTextField(
                    label: 'Vehicle',
                    initialValue: leads[0].customerVehicle.toString(),
                    keyBoardType: TextInputType.name,
                    onChanged: (String p0) {
                      vehicle = p0;
                    },
                    validator: (String? p0) {
                      return null;
                    }),
                buildItem('Progress', leads[0].customerProgress),
                buildEditableTextField(
                    label: 'Pax',
                    initialValue: leads[0].customerPax.toString(),
                    keyBoardType: TextInputType.number,
                    onChanged: (String p0) {
                      pax = p0;
                    },
                    validator: (String? p0) {
                      return null;
                    }),
                buildItem('Source', leads[0].customerSource),
                Obx(() {
                  return CustomDropDownButton(
                    dropdownValues: const <String>['Standard', 'Premium'],
                    value: selectedCategory.value != null &&
                            selectedCategory.value.isNotEmpty
                        ? selectedCategory.value
                        : null,
                    onChanged: (String? p0) {
                      selectedCategory.value = p0.toString();
                      log(selectedCategory.value);
                    },
                    labelText: 'Select Category',
                    errorText: '',
                  );
                }),
                buildEditableTextField(
                  label: 'Remarks',
                  keyBoardType: TextInputType.name,
                  initialValue: leads[0].customerRemarks.toString(),
                  onChanged: (String p0) {
                    remarks = p0;
                  },
                  validator: (String? p0) {
                    return null;
                  },
                ),
                if (leads[0].followUpDate == '')
                  const SizedBox()
                else
                  buildItem(
                    'Scheduled Date',
                    leads[0]
                        .followUpDate
                        .toString()
                        .parseFromIsoDate()
                        .toDateTime(),
                  ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: CustomButton().showGreyButton(
                              onTap: () => Get.back(),
                              isLoading: false,
                              label: 'Back')),
                      Obx(() {
                        return Expanded(
                            child: CustomButton().showBlueButton(
                                onTap: () async {
                                  await updateCustomer();
                                },
                                isLoading: updatingCustomer.value,
                                label: 'Confirm',
                                color: getColorFromHex(depColor)!));
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CustomTextFormField buildEditableTextField({
    required String label,
    required String initialValue,
    required TextInputType keyBoardType,
    required void Function(String)? onChanged,
    required String? Function(String?)? validator,
  }) =>
      CustomTextFormField(
        labelText: label,
        initialValue: initialValue,
        keyboardType: keyBoardType,
        onChanged: onChanged,
        validator: validator,
      );

  Future<void> updateCustomer() async {
    updatingCustomer.value = true;
    try {
      await LeadsRepository()
          .updateCustomer(
        customerID: int.parse(leads[0].customerId.toString()),
        customeraddress: leads[0].customerAddress,
        customercity: leads[0].customerCity,
        customerphone: leads[0].customerPhone,
        customerprogress: leads[0].customerProgress,
        customerremarks: leads[0].customerRemarks,
        customersource: leads[0].customerSource,
        customerwhatapp: leads[0].customerWhatsapp,
        customerCategory: selectedCategory.value ?? leads[0].customerCategory,
        customername: customerName ?? leads[0].customerName,
        customerpax: int.parse(pax ?? leads[0].customerPax.toString()),
        remarks: remarks ?? leads[0].customerRemarks,
        tour: selectedTourCode.value,
        branchId: branchId,
        depId: depID,
        customervehicle: vehicle ?? leads[0].customerVehicle,
      )
          .then((ApiResponse<Map<String, dynamic>> res) {
        if (res.status == ApiResponseStatus.completed) {
          updatingCustomer.value = false;
          loadLeadData(leadId.toString());
          Get.back();
        } else {
          log('Not complered');
        }
      });
    } catch (e) {
      log('wdiomciok ${e.toString()}');
    }
  }
}

final List<String> progress = <String>[
  'Select Progress',
  'Not Interested',
  'Interested',
  'Will Call You Later',
  'Booked',
  'Hold on',
  'Not Answering',
  'Waste'
];
