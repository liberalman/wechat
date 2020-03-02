import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wechat/provider/logic/global_logic.dart';
import '../im/info_handle.dart';
import '../tools/shared_util.dart';
import '../config/keys.dart';
import '../im/entity/i_person_info_entity.dart';

class GlobalModel extends ChangeNotifier {
  BuildContext context;

  String appName = "wechat";

  // user infomation
  String account = '';
  String nickName = 'Jacky';
  String avatar = '';
  int gender = 0; // 0 male, 1 female

  // Language setting
  List<String> currentLanguageCode = ["zh", "CN"];
  String currentLanguage = "中文";
  Locale currentLocale;

  // has gone to login page?
  bool goToLogin = true;

  GlobalLogic logic;

  GlobalModel() {
    logic = GlobalLogic(this);
  }

  void setContext(BuildContext context) {
    if (null == this.context) {
      this.context = context;
      Future.wait([
        logic.getCurrentLanguageCode(),
      ]).then((value) {
        // 载入支持的语言
        currentLocale = Locale(currentLanguageCode[0], currentLanguageCode[1]);
        refresh();
      });
    }
  }

  void refresh() {
    if (!goToLogin)
      initInfo(); // 已登录，载入个人信息
    notifyListeners(); // 这个方法是通知那些用到GlobalModel对象的widget刷新用的。
  }

  void initInfo() async {
    // 获取用户信息
    /*final data = await getUsersProfile([account]);
    if (null == data)
      return;*/
    String data = '{"nickname":"Jacky","avatar":"","gender":0}';
    List<dynamic> result = json.decode(data);
    if (Platform.isAndroid) {
      nickName = result[0]['nickname'];
      await SharedUtil.getInstance().saveString(Keys.nickName, result[0]['nickname']);
      avatar = result[0]['avatar'];
      await SharedUtil.getInstance().saveString(Keys.avatar, result[0]['avatar']);
      gender = result[0]['gender'];
      await SharedUtil.getInstance().saveInt(Keys.gender, result[0]['gender']);
    } else {
      IPersonInfoEntity model = IPersonInfoEntity.fromJson(result[0]);
      nickName = model.nickname;
      await SharedUtil.getInstance().saveString(Keys.nickName, model.nickname);
      avatar = model.avatar;
      await SharedUtil.getInstance().saveString(Keys.avatar, model.avatar);
      gender = model.gender;
      await SharedUtil.getInstance().saveInt(Keys.gender, model.gender);
    }
  }
}