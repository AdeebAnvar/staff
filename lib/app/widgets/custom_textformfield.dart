import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomWhiteTextFormField extends StatelessWidget {
  const CustomWhiteTextFormField({
    super.key,
    this.validator,
    required this.onChanged,
    bool? isPassword,
    Color? errorTextColor,
    this.controller,
    this.height,
    this.keyboardType,
    this.contentPadding,
    this.hintText,
    this.prefix,
    this.padding,
    this.isBorder = false,
    this.initialValue,
    this.textInputAction,
    int? maxLines,
    this.errorText,
    this.labelText,
    this.labelStyle,
    this.hintStyle,
  })  : isPassword = isPassword ?? false,
        errorTextColor = errorTextColor ?? Colors.red,
        maxLines = maxLines ?? 1;
  final String? errorText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isBorder;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final String? hintText;
  final Widget? prefix;
  final bool isPassword;
  final Color errorTextColor;
  final String? initialValue;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final Widget? labelText;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  @override
  Widget build(BuildContext context) {
    final RxBool passwordVisible = isPassword.obs;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Obx(() {
              return TextFormField(
                controller: controller,
                initialValue: initialValue,
                keyboardType: keyboardType,
                obscureText: passwordVisible.value,
                onChanged: onChanged,
                validator: validator,
                maxLines: maxLines,
                textInputAction: textInputAction,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: hintText,
                  label: labelText,
                  labelStyle: labelStyle,
                  hintStyle: hintStyle,
                  suffixIcon: isPassword
                      ? GestureDetector(
                          onTap: () {
                            passwordVisible.value = !passwordVisible.value;
                          },
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: Icon(
                              color: Colors.black,
                              passwordVisible.value
                                  ? Icons.lock
                                  : Icons.lock_open,
                              key: ValueKey<bool>(passwordVisible.value),
                            ),
                          ))
                      : null,
                  prefixIcon: prefix,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Text(
            errorText.toString(),
            style:
                TextStyle(color: errorTextColor, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
