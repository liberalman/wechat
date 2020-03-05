import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprintf/sprintf.dart';

import '../tools/wechat_flutter.dart';
import '../mqtt/mqtt_server_client.dart';

Future<void> sendTextMsg(String id, int type, String context) async {
  try {
    context = sprintf('{"sender":"1","peer":"%s","content":"%s"}', [id, context]);
    Mqtt.getInstance().publish("C2C/" + id, context);
    debugPrint('发送给 "$id" 消息 "$context"');
  } on PlatformException {
    debugPrint("发送消息失败");
  }
}
