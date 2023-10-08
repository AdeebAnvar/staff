import 'package:flutter/material.dart';
import 'custom_painter.dart';

class CustomStack extends StatelessWidget {
  const CustomStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Center(
          child: CustomPaint(
            size: Size(
              double.infinity,
              MediaQuery.of(context).size.height / 1.6,
            ),
            painter: Custompaint(),
          ),
        ),
      ],
    );
  }
}
