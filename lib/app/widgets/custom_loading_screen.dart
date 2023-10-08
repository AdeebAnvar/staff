import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class CustomLoadingScreen extends StatelessWidget {
  const CustomLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: getColorFromHex(depColor),
      ),
    );
  }
}
