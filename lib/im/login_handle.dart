import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../ui/dialog/show_toast.dart';

Future<void> init(BuildContext context) async {
  try{
    //var result = await im.init(appId);
    var result = "{}";
    debugPrint('初始化结果 ======>   ${result.toString()}');
  } on PlatformException {
    showToast(context, "initial failed");
  }

}