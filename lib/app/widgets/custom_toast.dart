import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/utils/constants.dart';

class CustomToastMessage {
  Future<bool?> showCustomToastMessage(String msg) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.white,
      textColor: getColorFromHex(depColor),
      fontSize: 15.0,
    );
  }
}
