import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../tools/wechat_flutter.dart';
import '../mqtt/mqtt_server_client.dart';

Future<void> sendTextMsg(String id, int type, String context) async {
  try {
    Mqtt.getInstance().publish("C2C/" + id, context);
    debugPrint('发送给 "$id" 消息 "$context"');
  } on PlatformException {
    debugPrint("发送消息失败");
  }
}
