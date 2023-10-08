import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/utils/constants.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_empty_screen.dart';
import '../../../widgets/custom_loading_screen.dart';
import '../../../widgets/custom_search_bar.dart';
import '../controllers/category_wise_leads_controller.dart';

class CategoryWiseLeadsView extends GetView<CategoryWiseLeadsController> {
  const CategoryWiseLeadsView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: CustomSearchBar(
              onchanged: (String text) => controller.onSearchTextChanged(text),
              onClickSearch: () {}),
        ),
        body: controller.obx(
          onEmpty: const CustomEmptyScreen(label: 'NO leads'),
          onLoading: const CustomLoadingScreen(),
          (CategoryWiseLeadsView? state) => Obx(() {
            if (controller.toursData.isNotEmpty) {
              return RefreshIndicator(
                color: Colors.white,
                backgroundColor: getColorFromHex(depColor),
                onRefresh: controller.loadData,
                child: GetBuilder<CategoryWiseLeadsController>(
                    builder: (CategoryWiseLeadsController dataController) {
                  return ListView.builder(
                    itemCount: dataController.toursData.length,
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 5),
                      child: GestureDetector(
                        onTap: () => dataController.onClickSingleLead(
                            dataController.toursData[index].tourCode),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(dataController.toursData[index].tourCode
                                    .toString()),
                                Text(dataController.toursData[index].tourName
                                    .toString()),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: getColorFromHex(depColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            } else {
              return const CustomEmptyScreen(label: 'No Leads');
            }
          }),
        ),
      ),
    );
  }
}
