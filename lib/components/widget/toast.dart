import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({
  required String msg,
  required ToastStates state,
  ToastGravity gravity = ToastGravity.CENTER,
}) => Fluttertoast.showToast(
  msg: msg,
  toastLength: Toast.LENGTH_LONG,
  timeInSecForIosWeb: 4,
  gravity: gravity,
  backgroundColor: choseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastStates { success, error, warning }

Color choseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;

    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}
