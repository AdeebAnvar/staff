import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/style.dart';

class CustomButton {
  Widget showBlueButton(
          {required final void Function() onTap,
          required final bool isLoading,
          required final String label,
          required final Color color}) =>
      blueButton(
          isLoading: isLoading, label: label, onTap: onTap, color: color);

  Widget showGreyButton({
    required final void Function() onTap,
    required final bool isLoading,
    required final String label,
  }) =>
      greyButton(
        isLoading: isLoading,
        label: label,
        onTap: onTap,
      );

  Widget blueButton(
          {required final void Function() onTap,
          required final bool isLoading,
          required final String label,
          required final Color color}) =>
      GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 1),
          height: 50,
          curve: Curves.bounceIn,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(isLoading ? 50 : 10),
          ),
          width: isLoading ? 50 : 100.w,
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(label,
                    style: subheading1.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ),
      );
  Widget greyButton({
    required final void Function() onTap,
    required final bool isLoading,
    required final String label,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 1),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(isLoading ? 25 : 15),
          ),
          width: isLoading ? 50 : 100.w,
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    label,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ),
      );
}
