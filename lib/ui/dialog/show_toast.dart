import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

// duration 持续时间，单位s
// gravity 程度
showToast(BuildContext context, String msg, {int duration = 1, int gravity}) {
  Toast.show(msg, context, duration: duration, gravity: gravity);
}