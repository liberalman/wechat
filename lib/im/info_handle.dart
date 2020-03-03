import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../tools/wechat_flutter.dart';
import '../provider/global_model.dart';

Future<dynamic> getUsersProfile(List<String> users, {Callback callback}) async {
  try {
    //var result = await
    return null;
  } on PlatformException {
    print('获取用户信息  失败');
  } on MissingPluginException {
    print('插件功能出错');
  }
}

Future<dynamic> getRemarkMethod(String id, {Callback callback}) async {
  try {
    //var result = await im.getRemark(id);
    var result = ""; // identifier
    callback(result);
    return result;
  } on PlatformException {
    print('获取备注失败');
  } on MissingPluginException{
    print('插件内这个功能IOS版还在开发中');
  }
}

Future<dynamic> setUsersProfileMethod(
    BuildContext context, {
      Callback callback,
      String nickNameStr = '',
      String avatarStr = '',
    }) async {
  final model = Provider.of<GlobalModel>(context);

  try {
    /*var result = await im.setUsersProfile(0, nickNameStr, avatarStr);
    if (result.toString().contains('succ')) {
      if (strNoEmpty(nickNameStr)) model.nickName = nickNameStr;
      if (strNoEmpty(avatarStr)) model.avatar = avatarStr;
    }
    callback(result);
    return result;*/
  } on PlatformException {
    print('设置个人信息 失败');
  }
}