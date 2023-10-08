import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    String? hintText,
    required this.onchanged,
    EdgeInsets? padding,
    required this.onClickSearch,
    this.focNode,
  })  : hintText = hintText ?? 'Search',
        padding =
            padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 16);
  final String hintText;
  final FocusNode? focNode;

  final Function(String text) onchanged;
  final EdgeInsets padding;
  final Function() onClickSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        focusNode: focNode,
        onTap: onClickSearch,
        decoration: InputDecoration(
            hintText: hintText,
            // hintStyle: title1,

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: getColorFromHex(depColor)!),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: getColorFromHex(depColor)!),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: getColorFromHex(depColor)!),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
        onChanged: (String value) => onchanged(value),
      ),
    );
  }
}
