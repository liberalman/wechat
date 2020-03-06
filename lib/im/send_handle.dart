import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprintf/sprintf.dart';

import '../tools/wechat_flutter.dart';
import '../mqtt/mqtt_server_client.dart';
import '../im/message_handle.dart';

Future<void> sendTextMsg(String sender, String roomId, int type, String context) async {
  try {
    String payload = sprintf('{"sender":"%s","room_id":"%s","content":"%s"}', [sender, roomId, context]);
    Mqtt.getInstance().publish("C2C/" + roomId, payload);
    debugPrint('$sender 发送给 "$roomId" 消息 "$payload"');
    addMessage(sender, roomId, context); // save to sqlite
  } on PlatformException {
    debugPrint("发送消息失败");
  }
}
