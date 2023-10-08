import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox(
      {super.key, required this.value, required this.onChanged});
  final bool value;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: value ? Colors.blue : Colors.transparent,
        border: Border.all(
          color: value ? Colors.blue : Colors.grey,
        ),
      ),
      child: Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.transparent,
        checkColor: Colors.white,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
