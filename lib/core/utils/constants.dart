import 'package:flutter/material.dart';

String depColor = '#0000FF';
Color? getColorFromHex(String? depColor) {
  String cleanColor = depColor!.toUpperCase().replaceAll('#', '');
  if (cleanColor.length == 6) {
    cleanColor = 'FF$cleanColor';
  }
  return Color(int.parse(cleanColor, radix: 16));
}
