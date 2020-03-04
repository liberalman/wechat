import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import '../entity/chat_list_entity.dart';
import '../entity/i_person_info_entity.dart';
import '../entity/message_entity.dart';
import '../entity/person_info_entity.dart';
import '../conversation_handle.dart';
import '../info_handle.dart';
import '../message_handle.dart';
import '../../common/check.dart';
import '../../config/const.dart';
import '../../mqtt/mqtt_server_client.dart';

// 首页聊天列表
class ChatList {
  ChatList({
    @required this.avatar,
    @required this.name,
    @required this.identifier,
    @required this.content,
    @required this.time,
    @required this.type,
    @required this.msgType,
  });

  final String avatar;
  final String name;
  final int time;
  final Map content;
  final String identifier;
  final dynamic type;
  final String msgType;
}

class ChatListData {
  Future<bool> isNull() async {
    final str = await getConversationsListData();
    List<dynamic> data = json.decode(str);
    return !listNoEmpty(data);
  }

  chatListData() async {
    List<ChatList> chatList = new List<ChatList>();
    String avatar;
    String name;
    int time;
    String identifier;
    dynamic type;
    String msgType;

    final str = await getConversationsListData();

    if (strNoEmpty(str) && str != '[]') {
      List<dynamic> data = json.decode(str);

      for (int i = 0; i < data.length; i++) {
        ChatListEntity model = ChatListEntity.fromJson(data[i]);
        type = model?.type ?? 'C2C';
        identifier = model?.peer ?? '';

        final profile = await getUsersProfile([model.peer]);
        List<dynamic> profileData = json.decode(profile);
        for (int i = 0; i < profileData.length; i++) {
          if (Platform.isIOS) {
            IPersonInfoEntity info = IPersonInfoEntity.fromJson(profileData[i]);

            if (strNoEmpty(info?.avatar) && info?.avatar != '[]') {
              avatar = info?.avatar ?? defIcon;
            } else {
              avatar = defIcon;
            }
            name = strNoEmpty(info?.nickname)
                ? info?.nickname
                : identifier ?? '未知';
          } else {
            PersonInfoEntity info = PersonInfoEntity.fromJson(profileData[i]);
            if (strNoEmpty(info?.avatar) && info?.avatar != '[]') {
              avatar = info?.avatar ?? defIcon;
            } else {
              avatar = defIcon;
            }
            name = strNoEmpty(info?.nickName)
                ? info?.nickName
                : identifier ?? '未知';
          }
        }

        final message = await getDimMessages(model.peer, num: 1);
        List<dynamic> messageData = json.decode(message);
        MessageEntity messageModel = MessageEntity.fromJson(messageData[0]);

        time = messageModel.time;
        msgType = messageModel.message.type;

        chatList.insert(
          0,
          new ChatList(
            type: type,
            identifier: identifier,
            avatar: avatar,
            name: name,
            time: time,
            content: messageData[0],
            msgType: msgType,
          ),
        );

        //Mqtt.getInstance().subscribe("testtopic/" + identifier);
      }
    }
    return chatList;
  }
}
