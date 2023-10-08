import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../../../widgets/custom_appBar.dart';
import '../../../widgets/custom_empty_screen.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/custom_textformfield.dart';
import '../controllers/fixed_itineraries_controller.dart';

class FixedItinerariesView extends GetView<FixedItinerariesController> {
  const FixedItinerariesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FixedItinerariesController controller =
        Get.put(FixedItinerariesController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(),
      body: controller.obx(
          onEmpty: const CustomEmptyScreen(label: 'No Fixed Tours'),
          (FixedItinerariesView? state) => ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) =>
                          controller.onChangeSearchValue(value),
                      decoration: InputDecoration(
                        hintText: 'Search in itinerarys',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    return controller.toursData.value.isNotEmpty
                        ? ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.toursData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    dense: true,
                                    title: Text(
                                        controller.toursData[index].tourName
                                            .toString(),
                                        style: subheading2),
                                    subtitle: Text(controller
                                        .toursData[index].tourCode
                                        .toString()),
                                    trailing: controller
                                                .toursData[index].tourPdf !=
                                            ''
                                        ? Text('Click to view',
                                            style: subheading2.copyWith(
                                                color: telecallerGreen))
                                        : Text('No fixed itineraries added',
                                            style: subheading2.copyWith(
                                                color: telecallerRed)),
                                    onTap: () {
                                      controller.toursData[index].tourPdf != ''
                                          ? controller.onClickViewItineraries(
                                              context,
                                              '',
                                              controller
                                                  .toursData[index].tourCode
                                                  .toString())
                                          : showDialog(
                                              barrierDismissible: controller
                                                          .toursData[index]
                                                          .tourPdf !=
                                                      ''
                                                  ? false
                                                  : true,
                                              context: context,
                                              builder: (BuildContext ctx) =>
                                                  AnimatedContainer(
                                                duration: const Duration(
                                                    microseconds: 600),
                                                child: AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  title: Text(
                                                      'No itineraries in ${controller.toursData[index].tourName}',
                                                      style: subheading1),
                                                  content: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: SvgPicture.asset(
                                                            'assets/empty.svg',
                                                            height: 100),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                    },
                                  ),
                                ),
                              );
                            },
                          )
                        : const CustomEmptyScreen(
                            label: 'No itineraries found ');
                  }),
                ],
              )),
    );
  }
}
