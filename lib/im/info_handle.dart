import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../tools/wechat_flutter.dart';

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
