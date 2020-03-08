import 'dart:convert';
import 'package:sprintf/sprintf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../tools/wechat_flutter.dart';
import './model/conversation.dart';

Future<dynamic> getConversationsListData({Callback callback}) async {
  try {
    /*var result = '[{"peer":"5c566802128c810b3772f9e5","type":"C2C","mConversation":{"text":"bbbb"}},'
        '{"peer":"5a5624e4ba18d80e4dd3162b","type":"C2C","mConversation":{"text":"bbbb"}},'
        '{"peer":"2","type":"C2C","mConversation":{"text":"bbbb"}},'
        '{"peer":"3","type":"C2C","mConversation":{"text":"aaaa"}}]';
    String strData = result.toString().replaceAll("'", '"');
    return strData;*/

    Conversation conversation = new Conversation();
    var list = await conversation.findSome(offset: 0, limit: 10); // 从本地sqlite找
    String str = "[ ";
    for (var cov in list) {
      str += sprintf('{"peer":"%s","type":"C2C"},', [cov.roomId]);
    }
    return str.substring(0, str.length - 1) + ']';
  } on PlatformException {
    debugPrint('获取会话列表失败');
  }
}

Future<dynamic> deleteConversationAndLocalMsgModel(int type, String id,
    {Callback callback}) async {
  try {
    //var result = await im.deleteConversationAndLocalMsg(type, id);
    //callback(result);
  } on PlatformException {
    print("删除会话和聊天记录失败");
  }
}

Future<dynamic> delConversationModel(String identifier, int type,
    {Callback callback}) async {
  try {
    //var result = await im.delConversation(identifier, type);
    //callback(result);
  } on PlatformException {
    print("删除会话失败");
  }
}

Future<dynamic> getUnreadMessageNumModel(int type, String id,
    {Callback callback}) async {
  try {
    //var result = await im.getUnreadMessageNum(type, id);
    //callback(result);
  } on PlatformException {
    print("获取未读消息数量失败");
  }
}

Future<dynamic> setReadMessageModel(int type, String id,
    {Callback callback}) async {
  try {
    //var result = await im.setReadMessage(type, id);
    //callback(result);
  } on PlatformException {
    print("设置消息为已读失败");
  }
}

// 在首页会话列表中添加会话记录
Future<dynamic> addConversation(String roomId, String type,
    {Callback callback}) async {
  try {
    int now = DateTime.now().millisecondsSinceEpoch;
    Conversation conversation = new Conversation(
        roomId: roomId, type: type, createTime: now, updateTime: now);
    var result = await conversation.find(roomId);
    if (null != result) // 已经存在，则不用添加到首页聊天列表中了
      return;
    else {
      // 不存在，则新增到首页聊天列表中
      await conversation.insert(conversation);
    }
    //callback(result);
  } on PlatformException {
    print("添加会话失败");
  }
}
