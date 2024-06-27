import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/consts.dart';

dynamic toastMessage({required String msg, required ToastType type}) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: type == ToastType.success
        ? Colors.green.shade400
        : type == ToastType.error
            ? Colors.red.withOpacity(.8)
            : Colors.grey.withOpacity(.8),
    textColor: Colors.white,
    fontSize: 16,
  );
}
