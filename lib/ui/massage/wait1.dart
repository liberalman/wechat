import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../im/model/chat_data.dart';
import '../../tools/wechat_flutter.dart';
import '../../provider/global_model.dart';
import '../message_view/Img_msg.dart';
import '../message_view/join_message.dart';
import '../message_view/quit_message.dart';
import '../message_view/sound_msg.dart';
import '../message_view/tem_message.dart';
import '../message_view/text_msg.dart';
import '../message_view/video_message.dart';

// 消息输入框
class SendMessageView extends StatefulWidget {
  final ChatData model;

  SendMessageView(this.model);

  @override
  _SendMessageViewState createState() => _SendMessageViewState();
}

class _SendMessageViewState extends State<SendMessageView> {
  @override
  Widget build(BuildContext context) {
    Map msg = widget.model.msg;
    String msgType = msg['type'];
    String msgStr = msg.toString();

    bool isI = Platform.isIOS;
    bool iosText = isI && msgStr.contains('text:');
    bool iosImg = isI && msgStr.contains('imageList:');
    var iosS = msgStr.contains('downloadFlag:') && msgStr.contains('second:');
    bool iosSound = isI && iosS;
    if (msgType == "Text" || iosText) {
      return new TextMsg(msg['text'], widget.model);
    } else if (msgType == "Image" || iosImg) {
      return new ImgMsg(msg, widget.model);
    } else if (msgType == 'Sound' || iosSound) {
      return new SoundMsg(widget.model);
    } else {
      return new Text('未知消息');
    }
  }
}
