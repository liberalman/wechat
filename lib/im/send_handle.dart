import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../tools/wechat_flutter.dart';

Future<void> sendTextMsg(String id, int type, String context) async {
  try {
    //var result = await im.sendTextMessages(id, context, type: type);
    //debugPrint('发送消息结果 ===> $result');
  } on PlatformException {
    debugPrint("发送消息失败");
  }
}
