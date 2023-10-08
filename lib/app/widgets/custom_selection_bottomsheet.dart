// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../core/theme/style.dart';
// import '../../core/utils/constants.dart';
// import '../modules/custom_booking/controllers/custom_booking_controller.dart';
// import 'create_itinerary_section.dart';

// Future<dynamic> onSelectRoomCategory({
//   required CustomBookingController controller,
// }) {
//   return Get.bottomSheet(
//     barrierColor: Colors.transparent,
//     elevation: 10,
//     enterBottomSheetDuration: const Duration(milliseconds: 500),
//     exitBottomSheetDuration: const Duration(milliseconds: 500),
//     Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       margin: const EdgeInsets.all(20),
//       child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.all(18),
//           child: Column(children: <Widget>[
//             const Text('Select room category'),
//             ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: controller.roomCategoryModel.length,
//               itemBuilder: (BuildContext context, int index) => Obx(() {
//                 return CheckboxListTile(
//                   value: controller.isCheckedRoomCategories[index] ?? false,
//                   onChanged: (bool? p0) {
//                     if (controller.selectedRoomModel.isNotEmpty) {
//                       controller.selectedRoomModel.clear();
//                     }
//                     if (controller.isCheckedRoomCategories[index] != true) {
//                       controller.selectedRoomCategories.add(int.parse(
//                           controller.roomCategoryModel[index].catId!));
//                       controller.isCheckedRoomCategories[index] = p0!;
//                     } else {
//                       controller.selectedRoomCategories
//                           // ignore: list_remove_unrelated_type
//                           .remove(controller.roomCategoryModel[index].catId);
//                       controller.isCheckedRoomCategories[index] = p0!;
//                     }

//                     log(controller.selectedRoomCategories.toString());
//                     log(p0.toString());
//                   },
//                   dense: true,
//                   activeColor: getColorFromHex(depColor),
//                   secondary: Text(
//                       controller.roomCategoryModel[index].catName.toString()),
//                 );
//               }),
//             )
//           ]),
//         ),
//       ),
//     ),
//   );
// }

// Future<dynamic> onSelectRoomType({
//   required CustomBookingController controller,
// }) {
//   return Get.bottomSheet(
//     barrierColor: Colors.transparent,
//     elevation: 10,
//     enterBottomSheetDuration: const Duration(milliseconds: 500),
//     exitBottomSheetDuration: const Duration(milliseconds: 500),
//     Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       margin: const EdgeInsets.all(20),
//       child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.all(18),
//           child: Column(children: <Widget>[
//             const Text('Select room type'),
//             ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: roomTypes.length,
//               itemBuilder: (BuildContext context, int index) => Obx(() {
//                 return CheckboxListTile(
//                   value: controller.isCheckedRoomTypes[index] ?? false,
//                   onChanged: (bool? p0) {
//                     if (controller.selectedRoomModel.isNotEmpty) {
//                       controller.selectedRoomModel.clear();
//                     }
//                     if (controller.isCheckedRoomTypes[index] != true) {
//                       controller.selectedRoomTypes.add(roomTypes[index]);
//                       controller.isCheckedRoomTypes[index] = p0!;
//                     } else {
//                       controller.selectedRoomTypes.remove(roomTypes[index]);
//                       controller.isCheckedRoomTypes[index] = p0!;
//                     }

//                     log(controller.selectedRoomTypes.toString());
//                     log(p0.toString());
//                   },
//                   dense: true,
//                   activeColor: getColorFromHex(depColor),
//                   secondary: Text(roomTypes[index]), //roomTypes[index]
//                 );
//               }),
//             )
//           ]),
//         ),
//       ),
//     ),
//   );
// }

// Future<dynamic> onSelectRoom({
//   required CustomBookingController controller,
// }) {
//   return Get.bottomSheet(
//     barrierColor: Colors.transparent,
//     elevation: 10,
//     enterBottomSheetDuration: const Duration(milliseconds: 500),
//     exitBottomSheetDuration: const Duration(milliseconds: 500),
//     Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       margin: const EdgeInsets.all(20),
//       child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.all(18),
//           child: Column(children: <Widget>[
//             const Text('Select room '),
//             ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: controller.selectedRoomTypes.length,
//               itemBuilder: (BuildContext context, int index) => Obx(() {
//                 return CheckboxListTile(
//                   value: controller.isCheckedRoomTypes[index] ?? false,
//                   onChanged: (bool? p0) {
//                     if (controller.isCheckedRoomTypes[index] != true) {
//                       controller.selectedRoomes[
//                               'Nigght ${controller.nights.value + 1}'] =
//                           controller.selectedRoomTypes;
//                       controller.isCheckedRoomTypes[index] = p0!;
//                     } else {
//                       controller.selectedRoomes.remove(index);
//                       controller.isCheckedRoomTypes[index] = p0!;
//                     }

//                     log(controller.selectedRoomes.toString());
//                     log(p0.toString());
//                   },
//                   dense: true,
//                   activeColor: getColorFromHex(depColor),
//                   secondary: Text(
//                       controller.selectedRoomTypes[index]), //roomTypes[index]
//                 );
//               }),
//             )
//           ]),
//         ),
//       ),
//     ),
//   );
// }

// Future<dynamic> onClickViewRooms({
//   required CustomBookingController controller,
// }) {
//   return Get.bottomSheet(
//     barrierColor: Colors.transparent,
//     elevation: 10,
//     enterBottomSheetDuration: const Duration(milliseconds: 500),
//     exitBottomSheetDuration: const Duration(milliseconds: 500),
//     Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       margin: const EdgeInsets.all(20),
//       child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.all(18),
//           child: Column(children: <Widget>[
//             Text('Select room', style: paragraph2),
//             const SizedBox(height: 10),
//             ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: controller.roomModel.length,
//               itemBuilder: (BuildContext context, int index) => Obx(() {
//                 return InkWell(
//                   onTap: () {
//                     if (controller.isSelectedRoom[index] != true) {
//                       controller.roomQTY[controller.roomModel[index].roomId!] =
//                           1;
//                       controller.selectedRoomModel[index] =
//                           controller.roomModel[index].roomBuilding.toString();
//                       controller.isSelectedRoom[index] = true;
//                     } else {
//                       controller.selectedRoomModel.remove(index);
//                       controller.paxCountForRoom.clear();
//                       controller.isSelectedRoom[index] = false;
//                     }
//                     log(controller.selectedRoomModel.toString());
//                   },
//                   child: Card(
//                     color: controller.isSelectedRoom[index] != true
//                         ? Colors.white
//                         : getColorFromHex(depColor),
//                     elevation: 4,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         buildLabel(
//                             label: 'Room number',
//                             color: controller.isSelectedRoom[index] != true
//                                 ? Colors.black
//                                 : Colors.white,
//                             data: controller.roomModel[index].roomNumber
//                                 .toString()),
//                         buildLabel(
//                             label: 'Room category',
//                             color: controller.isSelectedRoom[index] != true
//                                 ? Colors.black
//                                 : Colors.white,
//                             data: controller.roomModel[index].roomCategory
//                                 .toString()),
//                         buildLabel(
//                             label: 'Room address',
//                             color: controller.isSelectedRoom[index] != true
//                                 ? Colors.black
//                                 : Colors.white,
//                             data: controller.roomModel[index].roomBuilding
//                                 .toString()),
//                         buildLabel(
//                             label: 'Room type',
//                             color: controller.isSelectedRoom[index] != true
//                                 ? Colors.black
//                                 : Colors.white,
//                             data:
//                                 controller.roomModel[index].roomType.toString())
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//             ),
//             const SizedBox(height: 10),
//           ]),
//         ),
//       ),
//     ),
//   );
// }

// Future<dynamic> onSelectViewVehicles({
//   required CustomBookingController controller,
// }) {
//   return Get.bottomSheet(
//     barrierColor: Colors.transparent,
//     elevation: 10,
//     enterBottomSheetDuration: const Duration(milliseconds: 500),
//     exitBottomSheetDuration: const Duration(milliseconds: 500),
//     Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       margin: const EdgeInsets.all(20),
//       child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.all(18),
//           child: Column(children: <Widget>[
//             Text('Select vehicle', style: paragraph2),
//             const SizedBox(height: 10),
//             ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: controller.vehicleModel.length,
//               itemBuilder: (BuildContext context, int index) => Obx(() {
//                 return InkWell(
//                   onTap: () {
//                     if (controller.isSelectVehicle[index] != true) {
//                       controller.vehicleQTY[
//                           controller.vehicleModel[index].vehicleId!] = 1;
//                       controller.selectedVehicleModel[index] =
//                           controller.vehicleModel[index].vehicleId.toString();
//                       controller.isSelectVehicle[index] = true;
//                     } else {
//                       controller.selectedVehicleModel.remove(index);
//                       controller.paxCountForVehicle.clear();

//                       controller.vehicleQTY
//                           .remove(controller.vehicleModel[index].vehicleId);
//                       controller.isSelectVehicle[index] = false;
//                     }
//                   },
//                   child: Card(
//                     color: controller.isSelectVehicle[index] != true
//                         ? Colors.white
//                         : getColorFromHex(depColor),
//                     elevation: 4,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         buildLabel(
//                             label: 'Vehicle name',
//                             color: controller.isSelectVehicle[index] != true
//                                 ? Colors.black
//                                 : Colors.white,
//                             data: controller.vehicleModel[index].vehicleName
//                                 .toString()),
//                         buildLabel(
//                             label: 'vehicle category',
//                             color: controller.isSelectVehicle[index] != true
//                                 ? Colors.black
//                                 : Colors.white,
//                             data: controller.vehicleModel[index].categoryName
//                                 .toString()),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//             ),
//             const SizedBox(height: 10),
//           ]),
//         ),
//       ),
//     ),
//   );
// }

// Future<dynamic> onSelectVehicleCategory({
//   required CustomBookingController controller,
// }) {
//   return Get.bottomSheet(
//     barrierColor: Colors.transparent,
//     elevation: 10,
//     enterBottomSheetDuration: const Duration(milliseconds: 500),
//     exitBottomSheetDuration: const Duration(milliseconds: 500),
//     Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       margin: const EdgeInsets.all(20),
//       child: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Padding(
//           padding: const EdgeInsets.all(18),
//           child: Column(children: <Widget>[
//             const Text('Select vehicle category'),
//             ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: controller.vehicleCategoryModel.length,
//               itemBuilder: (BuildContext context, int index) => Obx(() {
//                 return CheckboxListTile(
//                   value: controller.isCheckedVehicleTypes[index] ?? false,
//                   onChanged: (bool? p0) {
//                     // controller.selectedVehicleTypes.clear();
//                     // controller.selectedVehicleModel.clear();
//                     if (controller.isCheckedVehicleTypes[index] != true) {
//                       controller.selectedVehicleTypes
//                           .add(controller.vehicleCategoryModel[index].catId!);
//                       controller.isCheckedVehicleTypes[index] = p0!;
//                     } else {
//                       controller.selectedVehicleTypes
//                           .remove(controller.vehicleCategoryModel[index].catId);

//                       controller.isCheckedVehicleTypes[index] = p0!;
//                     }

//                     log(controller.selectedVehicleTypes.toString());
//                     log(p0.toString());
//                   },
//                   dense: true,
//                   activeColor: getColorFromHex(depColor),
//                   secondary: Text(controller.vehicleCategoryModel[index].catName
//                       .toString()), //roomTypes[index]
//                 );
//               }),
//             )
//           ]),
//         ),
//       ),
//     ),
//   );
// }
