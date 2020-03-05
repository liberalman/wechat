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