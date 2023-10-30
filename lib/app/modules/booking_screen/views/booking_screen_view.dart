import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/utils/constants.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_loading_screen.dart';
import '../controllers/booking_screen_controller.dart';

class BookingScreenView extends GetView<BookingScreenController> {
  const BookingScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          // actions: <Widget>[
          //   IconButton.filledTonal(
          //       onPressed: () => controller.onClickPreviousResponses(),
          //       icon: const Icon(Icons.history_sharp)),
          //   const SizedBox(height: 10, width: 10),
          // ],
          ),
      body: controller.obx(
        onLoading: const CustomLoadingScreen(),
        (BookingScreenView? state) => RefreshIndicator(
          onRefresh: controller.loadData,
          child: ListView(
            children: <Widget>[
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.h),
                      Obx(
                        () {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: CustomButton().showBlueButton(
                                color: getColorFromHex(depColor)!,
                                isLoading: controller.isloading.value,
                                onTap: () => controller.onClickFixedItinerary(),
                                label: 'Fixed Tours'),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Obx(
                            () {
                              return GestureDetector(
                                onTap: () => controller.onClickCustomBooking(),
                                child: AnimatedContainer(
                                  margin: const EdgeInsets.all(10),
                                  duration: const Duration(seconds: 1),
                                  height: 35,
                                  curve: Curves.bounceIn,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        controller.isLoading.value ? 50 : 10),
                                  ),
                                  width:
                                      controller.isLoading.value ? 50 : 100.w,
                                  child: Center(
                                    child: controller.isLoading.value
                                        ? const CircularProgressIndicator(
                                            color: Colors.white)
                                        : const Text(
                                            'Custom Tour',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ),
              // Obx(() {
              //   return controller.downloadedPDFs.isEmpty
              //       ? const SizedBox()
              //       : ListView.builder(
              //           shrinkWrap: true,
              //           physics: const NeverScrollableScrollPhysics(),
              //           itemCount: controller.downloadedPDFs.length,
              //           itemBuilder: (BuildContext context, int index) {
              //             final String filePath =
              //                 controller.downloadedPDFs[index];
              //             return Card(
              //               elevation: 3,
              //               margin: const EdgeInsets.symmetric(
              //                   horizontal: 20, vertical: 10),
              //               shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(10)),
              //               child: Padding(
              //                 padding: const EdgeInsets.all(10.0),
              //                 child: ListTile(
              //                   dense: true,
              //                   leading: Image.asset(
              //                     'assets/PDF ICON.png',
              //                     color: Colors.blueAccent,
              //                   ),
              //                   onTap: () => controller.openDownloadedPDF(
              //                       filePath,
              //                       basenameWithoutExtension(filePath)),
              //                   subtitle: Text(filePath.split('/').last),
              //                   // trailing: Padding(
              //                   //   padding: const EdgeInsets.all(8.0),
              //                   //   child: PopupMenuButton<dynamic>(
              //                   //     elevation: 4,
              //                   //     padding: const EdgeInsets.all(20),
              //                   //     shape: RoundedRectangleBorder(
              //                   //       borderRadius: BorderRadius.circular(10),
              //                   //     ),
              //                   //     itemBuilder: (BuildContext context) =>
              //                   //         <PopupMenuItem<dynamic>>[
              //                   //       PopupMenuItem<dynamic>(
              //                   //         onTap: () => controller
              //                   //             .onDeleteFile(File(filePath)),
              //                   //         textStyle: subheading2,
              //                   //         value: 'Delete',
              //                   //         child: const Text('Delete'),
              //                   //       ),
              //                   //       PopupMenuItem<dynamic>(
              //                   //         onTap: () => controller
              //                   //             .onClickShare(File(filePath)),
              //                   //         textStyle: subheading2,
              //                   //         value: 'Share',
              //                   //         child: const Text('Share'),
              //                   //       ),
              //                   //     ],
              //                   //   ),
              //                   // ),
              //                   title: Text(filePath.split('/').last),
              //                 ),
              //               ),
              //             );
              //           },
              //         );
              // }),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildItem(String? label, String? data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
              height: 35,
              width: 150,
              child: Text(
                '$label :',
                style: subheading1,
              )),
          SizedBox(
            height: 35,
            width: 35.w,
            child: Text(
              data.toString(),
              style: subheading2,
            ),
          ),
        ],
      ),
    );
  }

  // PopupMenuButton<dynamic> popUp(File filePath) => PopupMenuButton<dynamic>(
  //       elevation: 4,
  //       padding: const EdgeInsets.all(20),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       itemBuilder: (BuildContext context) => <PopupMenuItem<dynamic>>[
  //         PopupMenuItem<dynamic>(
  //           onTap: () => controller.onDeleteFile(filePath),
  //           textStyle: subheading2,
  //           value: 'Delete',
  //           child: const Text('Delete'),
  //         ),
  //         PopupMenuItem<dynamic>(
  //           onTap: () => controller.onClickShare(filePath),
  //           textStyle: subheading2,
  //           value: 'TourMaker',
  //           child: const Text('TourMaker'),
  //         ),
  //       ],
  //     );
}
