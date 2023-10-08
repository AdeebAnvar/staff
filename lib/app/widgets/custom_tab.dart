import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../core/theme/style.dart';
import '../../core/utils/constants.dart';
import '../modules/custom_booking/controllers/custom_booking_controller.dart';

class CustomTabSection extends StatelessWidget {
  const CustomTabSection({
    super.key,
    required this.controller,
  });
  final CustomBookingController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              // color: getColorFromHex(depColor)!.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.isSelectedTab.value = 0;
                    },
                    child: Obx(
                      () {
                        return GestureDetector(
                          onTap: () {
                            controller.isSelectedTab.value = 0;
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    'Room ',
                                    textAlign: TextAlign.center,
                                    style: paragraph2,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                if (controller.isSelectedTab.value == 0)
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: getColorFromHex(depColor),
                                    ),
                                    width:
                                        50, // Adjust the width based on your tab width
                                    height: 10,
                                  )
                                else
                                  Container(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.isSelectedTab.value = 1;
                    },
                    child: Obx(
                      () {
                        return GestureDetector(
                          onTap: () {
                            controller.isSelectedTab.value = 1;
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  'Vehicle ',
                                  textAlign: TextAlign.center,
                                  style: paragraph2,
                                ),
                              ),
                              const SizedBox(height: 10),
                              if (controller.isSelectedTab.value == 1)
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: getColorFromHex(depColor),
                                  ),
                                  width:
                                      50, // Adjust the width based on your tab width
                                  height: 10,
                                )
                              else
                                Container(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Obx(
                //   () => controller.isTransit.value
                //       ? Expanded(
                //           child: Obx(() {
                //             return Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: InkWell(
                //                 onTap: () {
                //                   controller.isSelectedTab.value = 2;
                //                 },
                //                 child: AnimatedContainer(
                //                   duration: const Duration(milliseconds: 600),
                //                   padding: const EdgeInsets.all(10),
                //                   decoration: BoxDecoration(
                //                       color: controller.isSelectedTab.value == 2
                //                           ? getColorFromHex(depColor)
                //                           : Colors.transparent,
                //                       borderRadius: BorderRadius.circular(10)),
                //                   child: Center(
                //                     child: Text(
                //                       'Transit Days',
                //                       textAlign: TextAlign.center,
                //                       style: paragraph3.copyWith(
                //                           color:
                //                               controller.isSelectedTab.value ==
                //                                       2
                //                                   ? Colors.white
                //                                   : Colors.black),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             );
                //           }),
                //         )
                //       : SizedBox(),
                // )
              ],
            ),
          ),
        )
      ],
    );
  }
}
