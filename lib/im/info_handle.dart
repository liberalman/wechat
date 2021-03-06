import 'package:sprintf/sprintf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../tools/wechat_flutter.dart';
import '../provider/global_model.dart';
import '../im/model/user.dart';
import 'dart:convert';

Future<dynamic> getUsersProfile(List<String> users, {Callback callback}) async {
  try {
    /*Map<String, String> map = {
      '5c566802128c810b3772f9e5': '{"userId":"5c566802128c810b3772f9e5","nickname":"Andy","gender":0,"birthday":1583292499,'
          '"avatar":"https://1.gravatar.com/avatar/a3e54af3cb6e157e496ae430aed4f4a3?s=96&d=mm",'
          '"role":0,"level":1,"language":1,"allowType":1,"customInfo":{}}',
      '5a5624e4ba18d80e4dd3162b': '{"userId":"5a5624e4ba18d80e4dd3162b","nickname":"Liberalman","gender":1,"birthday":1583292499,'
          '"avatar":"https://image.hicool.top/libertyblog/img/avatarher.jpg",'
          '"role":0,"level":1,"language":1,"allowType":1,"customInfo":{}}'
    };*/
    User user = new User();
    String str = "[ ";
    for (var id in users) {
      var u = await user.find(id); // 先从本地sqlite找
      if(null == u) {
        u = new User();
        // 从远程服务器获取，并存储到本地
        var res = await GET("/user/" + id);
        String result = res.toString();
        if (result.contains('_id')) {
          var obj = json.decode(result);
          u.id = obj['_id'];
          u.nickName = obj['nickname'];
          u.avatar = obj['avatar'];
          user.insert(u);
        } else {
          debugPrint('error::' + result);
          continue;
        }
      }
      str += sprintf('{"userId":"%s","nickname":"%s","gender":1,'
          '"birthday":1583292499,"avatar":"%s","role":0,"level":1,'
          '"language":1,"allowType":1,"customInfo":{}},',
          [u.id, u.nickName, u.avatar]);
    }
    return str.substring(0, str.length - 1) + ']';
  } on PlatformException {
    print('获取用户信息  失败');
  } on MissingPluginException {
    print('插件功能出错');
  }
}

Future<dynamic> getUserProfile(String userId, {Callback callback}) async {
  try {
    Map<String, String> map = {
      '5c566802128c810b3772f9e5': '{"userId":"5c566802128c810b3772f9e5","nickname":"Andy","gender":0,"birthday":1583292499,'
          '"avatar":"https://1.gravatar.com/avatar/a3e54af3cb6e157e496ae430aed4f4a3?s=96&d=mm",'
          '"role":0,"level":1,"language":1,"allowType":1,"customInfo":{}}',
      '5a5624e4ba18d80e4dd3162b': '{"userId":"5a5624e4ba18d80e4dd3162b","nickname":"Liberalman","gender":1,"birthday":1583292499,'
          '"avatar":"https://image.hicool.top/libertyblog/img/avatarher.jpg",'
          '"role":0,"level":1,"language":1,"allowType":1,"customInfo":{}}'
    };
    return map[userId];
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
  } on MissingPluginException {
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
