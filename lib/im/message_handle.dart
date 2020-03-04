import '../common/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../tools/wechat_flutter.dart';

Future<dynamic> getDimMessages(String id,
    {int type, Callback callback, int num = 50}) async {
  try {
    //var result = await im.getMessages(id, num, type ?? 1);
    /*
[{ // IOS这么写
		"sender": "0",
		"message": {
			"text": "bb",
			"type": "Text"
		},
		"timeStamp": 1583292499,
	},
	{ // Android这么写
		"senderProfile": {
			"birthday": 1,
			"identifier": "1",
			"role": 1,
			"gender": 1,
			"level": 1,
			"nickName": "xxxxxxx",
			"language": 1,
			"customInfo": {},
			"selfSignature": "",
			"allowType": 1,
			"location": "",
			"customInfoUint": {}
		},
		"message": {
			"text": "cc",
			"type": "Text"
		},
		"timeStamp": 1583292499,
	}
]
    */
    Map<String, String> map = {
      '2': '[{"sender": "2", "message": { "text": "Hello Tom", "type": "Text" }, "timeStamp": 1583290101 },'
          '{"sender": "1", "message": { "text": "Hello 2", "type": "Text" }, "timeStamp": 1583290209 }]',
      '3': '[{"sender": "3", "message": { "text": "Hi 1", "type": "Text" }, "timeStamp": 1583291499 },'
          '{"sender": "1", "message": { "text": "Hello 3", "type": "Text" }, "timeStamp": 1583291999 }]',
    };
    return map[id];
  } on PlatformException {
    debugPrint('获取失败');
  }
}

Future<void> sendImageMsg(String userName, int type,
    {Callback callback, ImageSource source}) async {
  File image = await ImagePicker.pickImage(source: source);
  if (image == null) return;
  File compressImg = await singleCompressFile(image);

  try {
    //await im.sendImageMessages(userName, compressImg.path, type: type);
    //callback(compressImg.path);
  } on PlatformException {
    debugPrint("发送图片消息失败");
  }
}

Future<dynamic> sendSoundMessages(String id, String soundPath, int duration,
    int type, Callback callback) async {
  try {
    //var result = await im.sendSoundMessages(id, soundPath, type, duration);
    //callback(result);
  } on PlatformException {
    debugPrint('发送语音  失败');
  }
}
