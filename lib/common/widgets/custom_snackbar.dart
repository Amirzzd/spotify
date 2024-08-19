import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

class CustomSnackBar {
  static showSnack({context,String? message,bool? success,}) {
    IconSnackBar.show(
        context,
        duration: const Duration(seconds: 3),
        snackBarType: SnackBarType.fail,
        snackBarStyle: SnackBarStyle(
            labelTextStyle: const TextStyle(color: Colors.white),
            backgroundColor: success == true ? Colors.green : Colors.red),
        label: message!,
    );
  }
}

