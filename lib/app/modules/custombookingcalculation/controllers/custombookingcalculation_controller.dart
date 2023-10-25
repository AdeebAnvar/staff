// ignore_for_file: use_if_null_to_convert_nulls_to_bools

import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/theme/style.dart';
import '../../../data/models/local_models/custom_itinerary_datas.dart';
import '../../../data/models/network_models/telecaller_model.dart';
import '../../../data/repository/network_repo/custombookingrepo.dart';
import '../../../routes/app_pages.dart';
import '../../../services/dio_download.dart';
import '../views/custombookingcalculation_view.dart';

class CustombookingcalculationController extends GetxController
    with StateMixin<CustombookingcalculationView> {
  CustomItineraryDatas customItineraryDatas = CustomItineraryDatas();
  RxMap<String, Map<int, int>> paxCountForActivity =
      <String, Map<int, int>>{}.obs;
  RxMap<String, Map<int, int>> paxCountForFood = <String, Map<int, int>>{}.obs;
  RxMap<String, Map<String, String>> vehicleAmounts =
      <String, Map<String, String>>{}.obs;
  List<String?> roomPrices = <String?>[];
  List<String?> activityPrices = <String?>[];
  List<String?> vehiclePrices = <String?>[];
  List<String?> foodPrices = <String?>[];
  RxMap<String, Map<String, int>> vehicleQuantity =
      <String, Map<String, int>>{}.obs;
  RxMap<String, Map<num?, String>> activityAmount =
      <String, Map<num?, String>>{}.obs;
  RxMap<String, Map<int, bool>> isCheckedVehicleAddonPrice =
      <String, Map<int, bool>>{}.obs;
  RxMap<String, Map<int, bool>> isCheckedVehicleDayTourPrice =
      <String, Map<int, bool>>{}.obs;
  RxMap<String, Map<int, bool>> isCheckedVehicleDropOffPrice =
      <String, Map<int, bool>>{}.obs;
  RxMap<String, Map<int, bool>> isCheckedVehiclePickupPrice =
      <String, Map<int, bool>>{}.obs;
  RxInt advAmount = 2000.obs;
  RxInt extraAdvAmount = 0.obs;
  String? customerName;
  String? customerId;
  RxBool checkingAmount = false.obs;
  GetStorage storage = GetStorage();
  TeleCallerModel telecallerModel = TeleCallerModel();
  Uint8List? uint8Image;
  RxBool generatingPDF = false.obs;
  RxBool isProposal = true.obs;
  RxBool isCheckAmountClicked = false.obs;
  String? depId;
  String? branchId;
  String? tourId;
  RxMap<String, Map<String, int>> roomPrice = <String, Map<String, int>>{}.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await loadData();
  }

  String getPaxAmountOfActivty({required int paxCount, required num amount}) {
    final num sum = paxCount * amount;
    return sum.toString();
  }

  String getTotalPax({int dayIndex = 0, int? index = 0}) {
    log('kup day $dayIndex');
    log('kup ind $index');
    if (customItineraryDatas.adults != null &&
        customItineraryDatas.kids != null) {
      final int sum = customItineraryDatas.adults! + customItineraryDatas.kids!;
      paxCountForActivity['Day ${dayIndex + 1}']?[index!] = sum;
      log('grtg $sum');
      return sum.toString();
    } else if (customItineraryDatas.adults != null &&
        customItineraryDatas.kids == null) {
      paxCountForActivity['Day ${dayIndex + 1}']?[index!] =
          customItineraryDatas.adults!;
      return customItineraryDatas.adults.toString();
    } else if (customItineraryDatas.adults == null &&
        customItineraryDatas.kids != null) {
      paxCountForActivity['Day ${dayIndex + 1}']?[index!] =
          customItineraryDatas.kids!;
      return customItineraryDatas.kids.toString();
    } else {
      paxCountForActivity['Day ${dayIndex + 1}']?[index!] = 1;
      return '';
    }
  }

  Future<void> loadData() async {
    change(null, status: RxStatus.loading());
    if (Get.arguments != null) {
      customItineraryDatas = Get.arguments[0] as CustomItineraryDatas;
      customerId = Get.arguments[1] as String;
      customerName = Get.arguments[2] as String;
      tourId = Get.arguments[3] as String;
      vehicleQuantity.value = Get.arguments[4] as Map<String, Map<String, int>>;
      roomPrice.value = Get.arguments[5] as Map<String, Map<String, int>>;
      depId = await storage.read('depID') as String;
      branchId = await storage.read('branchID') as String;
      log('kmkttmi $vehicleQuantity');
      log('kmkttmi $roomPrice');

      telecallerModel =
          await storage.read('telecaller_data') as TeleCallerModel;
      for (int i = 0; i < 100; i++) {
        isCheckedVehicleAddonPrice['Day ${i + 1}'] ??= <int, bool>{}.obs;
        isCheckedVehicleAddonPrice['Day ${i + 1}']![i] = false;
        log('ewrg $isCheckedVehicleAddonPrice');
      }
      for (int i = 0; i < 100; i++) {
        isCheckedVehicleDayTourPrice['Day ${i + 1}'] ??= <int, bool>{}.obs;
        isCheckedVehicleDayTourPrice['Day ${i + 1}']?[i] = false;
      }
      for (int i = 0; i < 100; i++) {
        isCheckedVehicleDropOffPrice['Day ${i + 1}'] ??= <int, bool>{}.obs;
        isCheckedVehicleDropOffPrice['Day ${i + 1}']?[i] = false;
      }
      for (int i = 0; i < 100; i++) {
        isCheckedVehiclePickupPrice['Day ${i + 1}'] ??= <int, bool>{}.obs;
        isCheckedVehiclePickupPrice['Day ${i + 1}']?[i] = false;
      }
      // if (roomAmounts.isEmpty) {
      //   for (int i = 0; i < customItineraryDatas.rooms!.length; i++) {
      //     roomAmounts.assign('Day ${i + 1}', <String, String>{});
      //   }
      // }
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.empty());
      log('kmktt');
    }
  }

  Future<void> generatePDF() async {
    showPreferenceAskingDialogue();
  }

  List<List<String>> combineMaps(List<Map<String, List<String>>?> maps) {
    final List<List<String>> result = <List<String>>[];

    // Iterate over each map in the list
    for (final Map<String, List<String>>? inputMap in maps) {
      if (inputMap != null) {
        // Iterate over the keys in the current map
        inputMap.forEach((String day, List<String> activities) {
          final int key = int.tryParse(day.split(' ')[1]) ?? 0;

          // Ensure that result list has enough days to accommodate the current key
          while (result.length <= key) {
            result.add(<String>[]);
          }

          // Add items from the current map to the corresponding day's list
          result[key].addAll(activities);
        });
      }
    }

    return result;
  }

  void createPdf(pw.Document pdf, String imageUrl) {
    final pw.MemoryImage image =
        pw.MemoryImage(File(imageUrl).readAsBytesSync());

    return pdf.addPage(
      pw.MultiPage(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        header: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
              pw.Container(
                width: 80,
                height: 80,
                child: pw.Image(
                  image,
                  fit: pw.BoxFit.cover,
                ),
              ),
              pw.Divider(thickness: 2, color: PdfColors.grey),
              pw.SizedBox(height: 15)
            ],
          );
        },
        margin: const pw.EdgeInsets.symmetric(vertical: 30, horizontal: 25),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return <pw.Widget>[];
        },
//         build: (pw.Context context) {

//           return <pw.Widget>[
//             pw.Header(
//               decoration: pw.BoxDecoration(
//                   border: pw.Border.all(color: PdfColors.white)),
//               child: pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.center,
//                 children: <pw.Widget>[
//                   pw.Column(children: <pw.Widget>[
//                     pw.Text(
//                       data.tour ?? '',
//                       style: pw.TextStyle(
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 25,
//                       ),
//                     ),
//                     pw.Text(
//                       '${data.days ?? ''}D|${data.nights ?? ''}N',
//                       style: pw.TextStyle(
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 22,
//                       ),
//                     ),
//                   ]),
//                 ],
//               ),
//             ),
//             if (isProposal.value != true)
//               pw.Header(
//                   decoration: pw.BoxDecoration(
//                       border: pw.Border.all(color: PdfColors.white)),
//                   child: pw.Row(
//                       mainAxisAlignment: pw.MainAxisAlignment.center,
//                       children: <pw.Widget>[
//                         pw.Text('CONFIRM ITINERARY',
//                             style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold, fontSize: 18))
//                       ])),
//             if (isProposal.value)
//               pw.Paragraph(
//                 text:
//                     '*Note : This is just a referral itinerary Upon confirmation, please get in touch with our executive and ask for your itinerary confirmation. The itinerary here is not valid for your tour.',
//                 style: pw.TextStyle(
//                     color: PdfColors.red900,
//                     fontSize: 10,
//                     fontWeight: pw.FontWeight.bold),
//               ),
//             if (isProposal.value)
//               pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.center,
//                 children: <pw.Widget>[
//                   pw.Paragraph(
//                     text: '''
// *Note : This itinerary is only valid upto 5 days from ${DateTime.now().toDatewithMonthFormat()}''',
//                     style: pw.TextStyle(
//                         color: PdfColors.red900,
//                         fontSize: 10,
//                         fontWeight: pw.FontWeight.bold),
//                   ),
//                 ],
//               ),
//             pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.center,
//                 children: <pw.Widget>[
//                   pw.Paragraph(
//                       margin: const pw.EdgeInsets.all(10),
//                       text: '''
// A TOWER COMPLEX, KALVARY, JUNCTION, POOTHOLE ROAD, THRISSUR,
// KERALA 680004 | 04872383104 | 0487238410''',
//                       textAlign: pw.TextAlign.center,
//                       style: pw.TextStyle(fontNormal: pw.Font.courier()))
//                 ]),
//             pw.ListView.builder(
//               itemCount: data.days ?? 0,
//               itemBuilder: (pw.Context context, int dayIndex) {
//                 return pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: <pw.Widget>[
//                     pw.Header(
//                       textStyle: pw.TextStyle(
//                         fontWeight: pw.FontWeight.bold,
//                         fontSize: 24,
//                       ),
//                       child: pw.Text(
//                         'Day ${dayIndex + 1}',
//                         style: pw.TextStyle(
//                             fontWeight: pw.FontWeight.bold, fontSize: 20),
//                       ),
//                     ),
//                     pw.Paragraph(
//                       text: data.placesForSingleDay!['Day ${dayIndex + 1}']?[0]
//                               .placeDes ??
//                           '',
//                       style: const pw.TextStyle(fontSize: 15),
//                     ),
//                     if (data.foodForSingleDay?['Day ${dayIndex + 1}']?.any(
//                             (FoodModel food) =>
//                                 food.foodType == 'Break fast') ==
//                         true)
//                       pw.ListView.builder(
//                           itemBuilder: (pw.Context context, int foodIndex) {
//                             return pw.Row(children: <pw.Widget>[
//                               pw.Paragraph(
//                                   text:
//                                       'We will arrange you the ${data.foodForSingleDay?['Day ${dayIndex + 1}']?[foodIndex].foodType ?? ''} ${data.foodForSingleDay?['Day ${dayIndex + 1}']?[foodIndex].foodName ?? ''} on there . ')
//                             ]);
//                           },
//                           itemCount: data
//                                   .foodForSingleDay?['Day ${dayIndex + 1}']
//                                   ?.length ??
//                               0),
//                     pw.SizedBox(height: 10),
//                     if (data.vehiclesForSingleDay?['Day ${dayIndex + 1}'] !=
//                             null &&
//                         data.vehiclesForSingleDay?['Day ${dayIndex + 1}']
//                                 ?.isNotEmpty !=
//                             false)
//                       pw.Paragraph(
//                           text: 'Vehicles arranged for your tour today'),
//                     pw.ListView.builder(
//                         direction: pw.Axis.horizontal,
//                         itemBuilder: (pw.Context context, int vehicleIndex) {
//                           return pw.Row(
//                             children: <pw.Widget>[
//                               pw.Paragraph(
//                                   text:
//                                       ' ${data.vehiclesForSingleDay?['Day ${dayIndex + 1}']?[vehicleIndex].vehicleName ?? ''} ${data.vehiclesForSingleDay?['Day ${dayIndex + 1}']?[vehicleIndex].categoryName ?? ''}, '),
//                             ],
//                           );
//                         },
//                         itemCount: data
//                                 .vehiclesForSingleDay?['Day ${dayIndex + 1}']
//                                 ?.length ??
//                             0),
//                     pw.SizedBox(height: 10),
//                     pw.ListView.builder(
//                         itemBuilder: (pw.Context context, int addonIndex) {
//                           return pw.Paragraph(
//                               text: data
//                                       .addonsForSingleDay?[
//                                           'Day ${dayIndex + 1}']?[addonIndex]
//                                       .addonDes ??
//                                   '');
//                         },
//                         itemCount: data
//                                 .addonsForSingleDay?['Day ${dayIndex + 1}']
//                                 ?.length ??
//                             0),
//                     pw.SizedBox(height: 10),
//                     pw.ListView.builder(
//                         itemBuilder: (pw.Context context, int activityIndex) {
//                           return pw.Paragraph(
//                               text: data
//                                       .activitiesForSingleDay?[
//                                           'Day ${dayIndex + 1}']?[activityIndex]
//                                       .activityDes ??
//                                   '');
//                         },
//                         itemCount: data
//                                 .activitiesForSingleDay?['Day ${dayIndex + 1}']
//                                 ?.length ??
//                             0),
//                     pw.SizedBox(height: 10),
//                     if (data.roomsForSingleDay?['Day ${dayIndex + 1}'] !=
//                             null &&
//                         data.roomsForSingleDay?['Day ${dayIndex + 1}']
//                                 ?.isNotEmpty !=
//                             false)
//                       pw.ListView.builder(
//                           itemBuilder: (pw.Context context, int roomIndex) {
//                             return pw.Paragraph(
//                                 text:
//                                     'After the day ends we should accomodate you in ${data.roomsForSingleDay?['Day ${dayIndex + 1}']?[roomIndex].roomBuilding ?? ''} , room number ${data.roomsForSingleDay?['Day ${dayIndex + 1}']?[roomIndex].roomNumber ?? ''} ${data.roomsForSingleDay?['Day ${dayIndex + 1}']?[roomIndex].roomCategory ?? ''}  ');
//                           },
//                           itemCount: data
//                                   .vehiclesForSingleDay?['Day ${dayIndex + 1}']
//                                   ?.length ??
//                               0),
//                   ],
//                 );
//               },
//             ),
//             pw.NewPage(),
//             pw.SizedBox(height: 50),
//             pw.Paragraph(
//                 text: 'HDFC BANK',
//                 style:
//                     pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
//             pw.Paragraph(text: 'Account Holder : TRIPPENS'),
//             pw.Paragraph(text: 'Account Number : 50200065078880'),
//             pw.Paragraph(text: 'IFSC           : HDFC0000057'),
//             pw.Paragraph(text: 'Branch         : TRICHUR - PALACE ROAD'),
//             pw.SizedBox(height: 13),
//             // pw.Paragraph(
//             //     text: 'IDFC FIRST BANK',
//             //     style:
//             //         pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
//             // pw.Paragraph(text: 'Account Holder : TRIPPENS'),
//             // pw.Paragraph(text: 'Account Number : 10084901004'),
//             // pw.Paragraph(text: 'IFSC           : IDFB0080732'),
//             // pw.Paragraph(text: 'Branch         : : THRISSUR EAST FORT'),
//             // pw.SizedBox(height: 13),
//             pw.Paragraph(
//                 text: 'PAYMENT POLICY - ',
//                 style:
//                     pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
//             pw.Paragraph(
//                 text:
//                     '> A minimum payment is required for booking a tour - Non refundable'),
//             pw.Paragraph(
//               text: '(The minimum payment will vary depending on the tour)',
//               style: const pw.TextStyle(color: PdfColors.red900),
//             ),
//             pw.Paragraph(
//               text:
//                   '> 21-35 Days before date of departure : 50% of Cost \n 20 Days before date of departure : 100% of Total cost',
//             ),
//             pw.SizedBox(height: 13),
//             pw.Paragraph(
//                 text: 'CANCELLATION AND REFUND POLICY  - ',
//                 style:
//                     pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
//             pw.Paragraph(
//               text: '''
// > 60 Days & Prior to Arrival POLICY - 25% of the Tour/Service Cost.
// > 59 Days to 30 Days Prior To Arrival - 50% of the Tour/Service Cost.
// > 29 Days to 15 Days Prior To Arrival - 75% of the Tour/Service Cost.
// > 14 Days and less Prior To Arrival - No refund
// > Transportation and accommodation are as per itinerary only, if you have to change any of the
// same we will not be responsible for any kind of refund.
// > There will be no refund for add-ons.
// ''',
//             ),
//             if (isProposal.value != true)
//               pw.Row(
//                   mainAxisAlignment: pw.MainAxisAlignment.center,
//                   children: <pw.Widget>[
//                     pw.Column(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
//                         children: <pw.Widget>[
//                           pw.Text('Customer name : $customerName',
//                               style: pw.TextStyle(
//                                   decorationThickness: 20,
//                                   fontWeight: pw.FontWeight.bold)),
//                           pw.Text('Customer Id : $customerId'),
//                           pw.Text(
//                               'Tour date : ${data.tourStartingDateTime.toString().parseFrom24Hours().toDatewithMonthFormat()}',
//                               style: pw.TextStyle(
//                                   decorationThickness: 20,
//                                   fontWeight: pw.FontWeight.bold)),
//                           pw.Text('Adult (5 and above 5 years):${data.adults} ',
//                               style: pw.TextStyle(
//                                   decorationThickness: 20,
//                                   fontWeight: pw.FontWeight.bold)),
//                           if (data.kids != null)
//                             pw.Text('kids :${data.kids} ',
//                                 style: pw.TextStyle(
//                                     decorationThickness: 20,
//                                     fontWeight: pw.FontWeight.bold)),
//                           if (data.infants != null && data.infants != 0)
//                             pw.Text('kids :${data.infants} ',
//                                 style: pw.TextStyle(
//                                     decorationThickness: 20,
//                                     fontWeight: pw.FontWeight.bold)),
//                           pw.Text(
//                               'Executive name : ${telecallerModel.userName}',
//                               style: pw.TextStyle(
//                                   decorationThickness: 20,
//                                   fontWeight: pw.FontWeight.bold)),
//                           pw.Text('Package Rate : ${totalAmountOfPackage()}',
//                               style: pw.TextStyle(
//                                   decorationThickness: 20,
//                                   fontSize: 20,
//                                   fontWeight: pw.FontWeight.bold)),
//                           pw.Text(
//                               'Advance amount : ${advAmount.value + extraAdvAmount.value}',
//                               style: pw.TextStyle(
//                                   decorationThickness: 20,
//                                   fontSize: 20,
//                                   fontWeight: pw.FontWeight.bold)),
//                         ])
//                   ]),
//             pw.NewPage(),
//             pw.Paragraph(
//                 text: 'TERMS AND CONDITIONS',
//                 style:
//                     pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 22)),
//             pw.Paragraph(
//               text: '''
// 1. if you're not able to reach out the destination on time. That is not our responsibility
// 2. Hotel Check in time - 11.30 a.m. & checkout - 10.00 am.
// 3. The booking stands liable to be cancelled if 100% payment is not received less than 20 days before
// date of departure. If the trip is cancel due to this reason advance will not be refundable. If you are
// not pay the amount that in mentioned in payment policy then tour will be cancel.
// 4. There is no refund option in case you cancel the tour yourself.
// 5. All activities which are not mentioned in the above itinerary such as visiting additional spots or
// involving in paid activities, If arranging separate cab etc. is not included in this.
// 6. In case of using additional transport will be chargeable.
// 7. All transport on the tour will be grouped together. Anyone who deviates from it will be excluded
// from this package.
// 8. The company has the right for expelling persons who disagree with passengers or misrepresent
// the company during the trip.
// 9. The company does not allow passengers to give tips to the driver for going additional spots.
// 10. In case of cancellation due to any reason such as Covid, strike, problems on the part of railways,
// malfunctions, natural calamities etc., package amount will not be refunded.
// 11. The Company will not be liable for any confirmation of train tickets, flight tickets, other
// transportation or any other related items not included in the package.
// 12. In Case Of Events And Circumstances Beyond Our Control, We Reserve The Right To Change All
// Or Parts Of The Contents Of The Itinerary For Safety And Well Being Of Our Esteemed Passengers.
// 13. Bathroom Facility | Indian or European
// 14. In season rooms will not be the same as per itinerary but category will be the same (Budget
// economy).
// 15. Charge will be the same from the age of 5 years.
// 16. We are not providing tourist guide, if you are taking their service in your own cost we will not be
// responsible for the same.
// 17. You Should reach to departing place on time, also you should keep the time management or you
// will not be able to cover all the place.
// 18. If the climate condition affect the sightseeing & activities that mentioned in itinerary, then we
// won't provide you the additional spots apart from the itinerary.
// 19. Transportation timing 8 am to 6 pm, if use vehicle after that then cost will be extra
// 20. Will visit places as per itinerary only, if you visit other than this then cost will be extra
// 21. If any customers misbehave with our staffs improperly then we will cancel his tour immediately
// and after that he can't continue with this tour.
// 22. If the trip is not fully booked or cancelled due to any special circumstances, we will postpone the
// trip to another day. Otherwise, if the journey is to be done on the pre-arranged day, the customers
// will have to bear the extra money themselves.
// 23. If you have any problems with the tour, please notify us as soon as possible so that we can
// resolve the problem. If you raise the issue after the tour, we will not be able to help you.
// 24.Our company does not provide specific seats on the Volvo bus, if you need a seat particularly,
// please let the executive know during the confirmation of your reservation.(requires additional
// payment).
// ''',
//             ),
//           ];
//         },
        footer: (pw.Context context) {
          final String text =
              'Page ${context.pageNumber} of ${context.pagesCount} ';
          return pw.Container(
              margin: const pw.EdgeInsets.only(top: 1 * PdfPageFormat.cm),
              alignment: pw.Alignment.centerRight,
              child: pw.Text(text));
        },
      ),
    );
  }

  int vehiclePriceOFTour = 0;
  String calculateVehicleAmountInaDay(Map<String, String>? vehicleAmount) {
    if (vehicleAmount == null) {
      return '';
    }

    final int sum = vehicleAmount.values
        .map((String value) => int.tryParse(value) ?? 0)
        .fold(0, (int previousValue, int element) => previousValue + element);
    vehiclePriceOFTour = sum;
    return sum.toString();
  }

  int roomPriceOfTour = 0;

  String calculateRoomAmountInaDay(Map<String, String>? roomAmount) {
    if (roomAmount == null) {
      return '';
    }

    final int sum = roomAmount.values
        .map((String value) => int.tryParse(value) ?? 0)
        .fold(0, (int previousValue, int element) => previousValue + element);
    roomPriceOfTour = sum;
    return sum.toString();
  }

  int activityPriceOFTour = 0;

  String calculateActivityAmountInaDay(Map<num?, String>? activityAmount) {
    if (activityAmount == null) {
      return '';
    }

    final int sum = activityAmount.values
        .map((String value) => int.tryParse(value) ?? 0)
        .fold(0, (int previousValue, int element) => previousValue + element);
    activityPriceOFTour = sum;
    return sum.toString();
  }

  void showPreferenceAskingDialogue() {
    Get.dialog(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Align(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 45,
                  width: 220,
                  child: DefaultTextStyle(
                    style: subheading1.copyWith(),
                    child: const Text('Is this the confirmed itinerary?!',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        isProposal.value = true;
                        createItinerary();
                        Get.back();
                      },
                      style: TextButton.styleFrom(
                        minimumSize: const Size(100, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        foregroundColor: fontColor,
                        backgroundColor:
                            const Color.fromARGB(255, 232, 231, 233),
                      ),
                      child: const Text('No'),
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: englishViolet),
                      onPressed: () {
                        isProposal.value = false;
                        createItinerary();
                        // booking();
                        Get.back();
                      },
                      child: const Text('Yes'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createItinerary() async {
    generatingPDF.value = true;
    try {
      final pw.Document pdf = pw.Document();

      await downloadImage(telecallerModel.depImage.toString())
          .then((String? value) => createPdf(pdf, value.toString()));

      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String pdfPath = '${appDocDir.path}/custom itinerary.pdf';
      final File pdfFile = File(pdfPath);
      await pdfFile.writeAsBytes(await pdf.save()).then((File value) =>
          Get.toNamed(Routes.NO_INTERNET, arguments: <String>[pdfPath]));
      generatingPDF.value = false;
      if (isProposal.value != true) {
        final Map<String, List<String>>? placesForSingleDayName =
            customItineraryDatas.placesForSingleDayName;
        final Map<String, List<String>>? addonsForSingleDayName =
            customItineraryDatas.addonsForSingleDayName;
        final Map<String, List<String>>? activitiesForSingleDayName =
            customItineraryDatas.activitiesForSingleDayName;

        final List<Map<String, List<String>>?> inputMaps =
            <Map<String, List<String>>?>[
          placesForSingleDayName,
          addonsForSingleDayName,
          activitiesForSingleDayName,
        ];
        final List<String> bookables = customItineraryDatas.roomNames! +
            customItineraryDatas.vehicleNames!;

        final List<List<String>> resultList = combineMaps(inputMaps);
        log(resultList.toString());
        CustomBookingRepo().customBooking(
          customerId: customerId.toString(),
          amountPayable: totalAmountOfPackage(),
          advPayment: '${advAmount.value + extraAdvAmount.value}',
          tasks: resultList,
          bookables: bookables,
          tourId: tourId.toString(),
          tourStartingDate:
              customItineraryDatas.tourStartingDateTime.toString(),
          tourEndingDate: customItineraryDatas.tourEndingDateTime.toString(),
          depID: depId.toString(),
          branchId: branchId.toString(),
          filePath: pdfPath,
        );
      }
    } catch (e) {
      generatingPDF.value = false;

      log('PDF CREATE CATCH $e');
    }
  }

  int roomPriceOFTour = 0;

  String getTotalAmountOfRooms(List<String?> roomPrices, int? nights) {
    if (roomPrices == null) {
      return '';
    }
    final int sum = roomPrices.fold(
        0,
        (int previousValue, String? element) =>
            previousValue + (element != null ? int.parse(element) : 0));
    final int total = sum * nights!;
    roomPriceOFTour = total;
    return total.toString();
  }

  int foodPriceOFTour = 0;

  String getTotalAmountOfFood(List<String?> roomPrices, int? nights) {
    if (roomPrices == null) {
      return '';
    }
    final int sum = roomPrices.fold(
        0,
        (int previousValue, String? element) =>
            previousValue + (element != null ? int.parse(element) : 0));
    foodPriceOFTour = sum;
    return sum.toString();
  }

  String getAmountOfPackage(int vehiclePriceOFTour, int roomPriceOFTour,
      int activityPriceOFTour, int foodPriceOFTour) {
    final int sum = vehiclePriceOFTour +
        roomPriceOfTour +
        activityPriceOFTour +
        foodPriceOFTour;
    return sum.toString();
  }

  String totalAmountOfPackage() {
    checkingAmount.value = true;

    try {
      final int vr = vehicleRate();
      log('vr $vr');
      final int rr = roomRate();
      log('rr $rr');

      final int ar = activityRate();
      log('ar $ar');

      final int sum = vr + rr + ar;
      final num total = sum / customItineraryDatas.adults!;
      checkingAmount.value = false;

      return total.toString();
    } catch (e) {
      checkingAmount.value = false;
      log('totalAmountOfPackage $e');
      return '0';
    }
  }

  int roomRate() {
    try {
      log(roomPrice.toString());
      log(customItineraryDatas.paxCountForRoom.toString());
      log(customItineraryDatas.roomCosts.toString());

      final Map<String, int> sumMap = <String, int>{};

      // Calculate the sum of values in roomPrice
      roomPrice.forEach((String night, Map<String, int> values) {
        values.forEach((String acUnit, int value) {
          sumMap[acUnit] ??= 0; // Initialize sum to 0 if it doesn't exist
          sumMap[acUnit] =
              (sumMap[acUnit] ?? 0) + value; // Ensure non-null values
        });
      });

      // Calculate the total sum across all A/C units
      final int totalSum =
          sumMap.values.fold(0, (int prev, int curr) => prev + curr);

      return totalSum;
    } catch (e) {
      // Handle any exceptions that may occur during the calculation
      log('Error: $e');
      return 0; // Return 0 or handle the error as needed
    }
  }

  int vehicleRate() {
    try {
      if (vehiclePrices.isNotEmpty && vehiclePrices != null) {
        final List<int> vehicleTourPrices = vehiclePrices
            .map((String? price) => int.tryParse(price ?? '0') ?? 0)
            .toList();
        log(vehicleTourPrices.toString());
        return vehicleTourPrices.fold(0, (int sum, int price) => sum + price);
      } else {
        return 0;
      }
    } catch (e) {
      log('vehicleRate $e');
      return 0;
    }
  }

  int activityRate() {
    // Convert the keys and values of the outer map to lists
    try {
      if (activityAmount.values.isNotEmpty && activityAmount.values != null) {
        final List<Map<num?, String>> valuesList =
            activityAmount.values.toList();

        // Convert the inner maps to lists
        final List<List<num?>> innerKeysList = <List<num?>>[];
        final List<List<String>> innerValuesList = <List<String>>[];

        for (final Map<num?, String> innerMap in valuesList) {
          final List<num?> innerKeys = innerMap.keys.toList();
          final List<String> innerValues = innerMap.values.toList();
          innerKeysList.add(innerKeys);
          innerValuesList.add(innerValues);
        }
        final List<List<int>> convertedInnerValuesList = <List<int>>[];
        for (final List<String> innerList in innerValuesList) {
          final List<int> convertedInnerList = <int>[];
          for (final String stringValue in innerList) {
            final int intValue = int.parse(stringValue);
            convertedInnerList.add(intValue);
          }
          convertedInnerValuesList.add(convertedInnerList);
        }
        final List<int> dailyCosts = <int>[];
        for (int i = 0; i < innerKeysList.length; i++) {
          int totalCost = 0;
          for (int j = 0; j < innerKeysList[i].length; j++) {
            totalCost += (innerKeysList[i][j] ?? 0).toInt() *
                convertedInnerValuesList[i][j];
          }
          dailyCosts.add(totalCost);
        }

        // Calculate the overall cost for the entire stay
        final int overallCost = dailyCosts.reduce((int a, int b) => a + b);

        // Calculate the activity rate or perform any necessary operations here
        // Replace with your calculation
        log('rgrt $overallCost');
        return overallCost; // Return the calculated activity rate
      } else {
        return 0;
      }
    } catch (e) {
      log('activityRate $e');
      return 0;
    }
  }
}
