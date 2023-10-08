import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../core/theme/style.dart';
import '../controllers/calling_page_controller.dart';

class CallingPageView extends GetView<CallingPageController> {
  const CallingPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 128.0),
              child: CircleAvatar(radius: 60),
            ),
            const Spacer(),
            CircleAvatar(
              radius: 30,
              backgroundColor: telecallerRed,
              child: const Icon(Icons.call_end_outlined),
            ),
            const SizedBox(height: 130)
          ],
        ),
      ),
    );
  }
}
