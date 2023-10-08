import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/style.dart';
import '../../core/utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key, Widget? leading, this.title, this.actions})
      : leading = leading ??
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: getColorFromHex(depColor),
              ),
              onPressed: () {
                Get.back();
              },
            );
  final Widget? title;
  final List<Widget>? actions;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        actions: actions,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        titleTextStyle: heading3,
        title: title,
        centerTitle: true,
        leading: leading);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
