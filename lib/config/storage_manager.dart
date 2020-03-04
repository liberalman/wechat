import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wechat/im/model/conversation_data.dart';
import 'package:wechat/tools/shared_util.dart';
import 'package:wechat/tools/sqlite_helper.dart';
import './keys.dart';

class StorageManager {
  // app global configuration
  static SharedPreferences sharedPreferences;

  // 数据初始化
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    ConversationData conversation = new ConversationData(id: 1, userId: "1", content: "hello",createTime: 1583292499);
    await conversation.insert(conversation);
    var list = await conversation.selectSome(offset: 0, limit: 10);
    for (var cov in list) {
      debugPrint(cov.content);
      debugPrint(cov.userId);
    }
    await conversation.delete(1);
  }

  initAutoLogin() async {
    try {
      final hasLogged = await SharedUtil.getInstance().getBoolean(Keys.hasLogged);
      final currentUser = "";
      if (hasLogged)
        if (currentUser == '' || null == currentUser) {
          final account = await SharedUtil.getInstance().getString(Keys.account);
        }
    } on PlatformException {
      print("你已登录或者其他错误");
    }
  }
}