import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import '../entity/person_info_entity.dart';
import '../entity/i_person_info_entity.dart';
import '../info_handle.dart';
import '../all_im.dart';

class ChatData {
  final Map msg;
  final String userId;
  final int time;
  final String nickName;
  final String avatar;

  ChatData({
    @required this.msg,
    this.avatar,
    this.time,
    this.nickName,
    this.userId,
  });
}

class ChatDataRep {
  addData(String sender, String roomId, String content) async {
    await addMessage(sender, roomId, content);
  }

  repData(String roomeId, int type) async {
    List<ChatData> chatData = new List<ChatData>();
    final chatMsgData = await getDimMessages(roomeId, type: type);
    if (Platform.isAndroid) {
      List chatMsgDataList = json.decode(chatMsgData);
      for (int i = 0; i < chatMsgDataList.length; i++) {
        PersonInfoEntity model =
            PersonInfoEntity.fromJson(chatMsgDataList[i]['senderProfile']);
        chatData.insert(
          0,
          new ChatData(
            msg: chatMsgDataList[i]['message'],
            avatar: model.avatar,
            time: chatMsgDataList[i]['timeStamp'],
            nickName: model.nickName,
            userId: model.userId,
          ),
        );
      }
    } else { // 如果是IOS，则如此处理
      List chatMsgDataList = json.decode(chatMsgData);
      for (int i = 0; i < chatMsgDataList.length; i++) {
        final info = await getUsersProfile([chatMsgDataList[i]['sender']]); // 根据发送者id查询他的详情
        List infoList = json.decode(info);
        IPersonInfoEntity model = IPersonInfoEntity.fromJson(infoList[0]);
        chatData.insert(
          0,
          new ChatData(
            msg: chatMsgDataList[i]['message'],
            avatar: model.avatar,
            time: chatMsgDataList[i]['timeStamp'],
            nickName: model.nickname,
            userId: chatMsgDataList[i]['sender'],
          ),
        );
      }
    }
    return chatData;
  }
}
