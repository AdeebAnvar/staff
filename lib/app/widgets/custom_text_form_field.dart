import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.validator,
      this.onChanged,
      this.keyboardType,
      this.labelText,
      this.textInPutAction,
      this.initialValue});
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? labelText;
  final String? initialValue;
  final TextInputAction? textInPutAction;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(10)),
        child: TextFormField(
          textInputAction: textInPutAction,
          validator: validator,
          onChanged: onChanged,
          keyboardType: keyboardType,
          initialValue: initialValue,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            labelText: labelText,
            isDense: true,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
