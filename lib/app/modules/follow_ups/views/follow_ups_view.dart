import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../../../../core/utils/constants.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_empty_screen.dart';
import '../../../widgets/custom_loading_screen.dart';
import '../../../widgets/custom_search_bar.dart';
import '../controllers/follow_ups_controller.dart';

class FollowUpsView extends GetView<FollowUpsController> {
  const FollowUpsView({super.key});
  @override
  Widget build(BuildContext context) {
    final FollowUpsController controller = Get.put(FollowUpsController());

    return Scaffold(
      extendBody: true,
      appBar: CustomAppBar(
        title: CustomSearchBar(
          onchanged: (String text) {},
          onClickSearch: onClickSearch,
          focNode: controller.searchFocusNode,
          hintText: 'search in FollowUps leads ',
        ),
      ),
      body: controller.obx(
        onLoading: const CustomLoadingScreen(),
        (FollowUpsView? state) => Column(
          children: <Widget>[
            const SizedBox(height: 30),
            SizedBox(
              height: 80,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Pending Leads',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                      const SizedBox(width: 28),
                      Container(
                        width: 59,
                        height: 43,
                        decoration: BoxDecoration(
                          color: telecallerRed,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Obx(() {
                            return Text(
                              controller.followup.length.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Colors.white),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              // width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: getColorFromHex(depColor),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'ID',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                  Text('Lead Name',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800)),
                  Text('status',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            Obx(
              () => controller.followup.isNotEmpty
                  ? Expanded(
                      child: RefreshIndicator(
                        onRefresh: controller.loadInitialData,
                        color: Colors.white,
                        backgroundColor: getColorFromHex(depColor),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: controller.scrollController,
                          child: Column(
                            children: <Widget>[
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.followup.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        buildSingleLead(index),
                                separatorBuilder: (BuildContext context,
                                        int index) =>
                                    const Divider(endIndent: 10, indent: 10),
                              ),
                              Obx(
                                () => controller.isLoading.value
                                    ? CircularProgressIndicator(
                                        color: getColorFromHex(depColor),
                                      )
                                    : const SizedBox(),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomEmptyScreen(label: "No Follow Up's"),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSingleLead(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      child: ListTile(
        dense: true,
        onTap: () => controller
            .onTapSingleLead(controller.followup[index].leadId.toString()),
        title: Center(
          child: Text(
            controller.followup[index].customerName.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        leading: ActionChip(
          label: Text(
            controller.followup[index].cid.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onPressed: () => controller
              .onTapSingleLead(controller.followup[index].leadId.toString()),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: getColorFromHex(depColor),
        ),
        trailing: Text(
          controller.followup[index].customerProgress.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Future<dynamic> onClickSearch() async {
    controller.searchFocusNode.unfocus();
    return Get.dialog(
      barrierDismissible: false,
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 240, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Material(
              borderRadius: BorderRadius.circular(10),
              animationDuration: const Duration(seconds: 2),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(Icons.close))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: CustomSearchBar(
                            onchanged: (String p0) => controller.name = p0,
                            hintText: 'Search name',
                            onClickSearch: () {},
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => controller.searchByName(),
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: CustomSearchBar(
                            onchanged: (String p0) => controller.id = p0,
                            hintText: 'Search ID',
                            onClickSearch: () {},
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => controller.searchById(),
                            child: const Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
