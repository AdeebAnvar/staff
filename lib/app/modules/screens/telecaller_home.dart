import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/theme/style.dart';
import '../../../core/utils/constants.dart';
import '../home/controllers/home_controller.dart';

class TelecallerHomeScreen extends StatelessWidget {
  const TelecallerHomeScreen({super.key, required this.homeController});
  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: homeController.loadData,
      child: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: homeController.onClickProfile,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        homeController.telecallerData[0].profileImage != '' &&
                                homeController.telecallerData[0].profileImage !=
                                    null
                            ? NetworkImage(
                                homeController.telecallerData[0].profileImage
                                    .toString(),
                              )
                            : null,
                    backgroundColor: getColorFromHex(depColor),
                    child:
                        homeController.telecallerData[0].profileImage != '' &&
                                homeController.telecallerData[0].profileImage !=
                                    null
                            ? const SizedBox()
                            : Text(
                                homeController.telecallerData[0].userName!
                                    .substring(0, 1)
                                    .toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 50, color: Colors.white),
                              ),
                  ),
                ),
              ),
              const SizedBox(height: 20, width: 20),
            ],
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Hi',
                          style: TextStyle(
                            fontSize: 20,
                            color: getColorFromHex(depColor),
                          ),
                        ),
                        const SizedBox(
                          width: 130,
                        )
                      ],
                    ),
                    Text(
                      homeController.telecallerData[0].userName!.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'enigma',
                        fontSize: 40,
                        color: getColorFromHex(depColor),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Points Earned By You ${homeController.teleCallerAnalytics.value.points} / ${homeController.teleCallerAnalytics.value.targetPoints}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      homeController.teleCallerAnalytics.value.points! <=
                              homeController
                                  .teleCallerAnalytics.value.targetPoints!
                          ? '(You are in danger zone)'
                          : homeController.teleCallerAnalytics.value.points! <=
                                  600
                              ? '(Keep it up , you are moving to safer zone)'
                              : '(You are in safe zone)',
                      style: TextStyle(
                        color:
                            homeController.teleCallerAnalytics.value.points! <=
                                    homeController
                                        .teleCallerAnalytics.value.targetPoints!
                                ? telecallerRed
                                : homeController.teleCallerAnalytics.value
                                            .points! <=
                                        600
                                    ? Colors.amber
                                    : telecallerGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.w),
          buildTile(
              icon: Icons.category,
              label: 'Follow Ups',
              onTap: homeController.onClickFollowUps),
          const SizedBox(height: 17),
          buildTile(
              icon: Icons.person,
              label: 'Fresh Leads',
              onTap: homeController.onClickFreshLeads),
          const SizedBox(height: 17),
          buildTile(
              icon: Icons.person,
              label: 'Old Leads',
              onTap: () => homeController.onClickOldLeads()),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  GestureDetector buildTile(
      {IconData? icon, String? label, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: AnimatedBuilder(
            animation: homeController.animation,
            builder: (BuildContext context, Widget? child) {
              return Transform.scale(
                scale: homeController.animation.value,
                child: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        icon,
                        color: getColorFromHex(depColor),
                      ),
                      Text(
                        label ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Icon(Icons.arrow_right)
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
