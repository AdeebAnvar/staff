import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/theme/style.dart';

class CustomEmptyScreen extends StatelessWidget {
  const CustomEmptyScreen({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset('assets/empty.svg'),
            const SizedBox(height: 50),
            Text(
              label,
              style: subheading2,
            ),
          ],
        ),
      ),
    );
  }
}
