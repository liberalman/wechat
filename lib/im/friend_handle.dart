import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprintf/sprintf.dart';
import '../ui/dialog/show_toast.dart';
import '../common/route.dart';
import '../http/api.dart';
import './model/friend.dart';

typedef OnSuCc = void Function(bool v);

Future<dynamic> addFriend(String userName, BuildContext context,
    {OnSuCc suCc}) async {
  try {
    //var result = await im.addFriend(userName);
    var result = "Friend_Exist";
    if (result.toString().contains('Friend_Exist')) {
      showToast(context, '朋友已存在');
    } else if (result.toString().contains('30014')) {
      showToast(context, '对方好友人数上限');
      return;
    } else if (result.toString().contains('30003')) {
      showToast(context, '添加的这个账号不存在');
      return;
    } else {
      showToast(context, '添加成功');
    }
    if (suCc == null) {
      popToHomePage();
    } else {
      suCc(true);
    }
  } on PlatformException {
    debugPrint('Dim添加好友  失败');
  }
}

Future<dynamic> delFriend(String userName, BuildContext context,
    {OnSuCc suCc}) async {
  try {
    //var result = await im.delFriend(userName);
    var result = "ucc";
    if (result.toString().contains('ucc')) {
      showToast(context, '删除成功');
    } else {
      showToast(context, result);
    }

    if (suCc == null) {
      popToHomePage();
    } else {
      suCc(true);
    }

    return result;
  } on PlatformException {
    debugPrint('删除好友  失败');
  }
}

Future<dynamic> getContactsFriends(String userId) async {
  try {
    /*var result = '[{"userId":"5a5624e4ba18d80e4dd3162b","addTime":1583292499,"addWording":"1","remark":"x","addSource":"",'
        '"profile":{"nickname":"Liberalman","avatar":"https://image.hicool.top/libertyblog/img/avatarher.jpg","gender":0,'
        '"birthday":1583292499,"role":0,"gender":1,"level":1,"language":1,'
        '"allowType":1,"customInfo":{}},"groups":[],"customInfo":{} },'
        '{"userId":"5c566802128c810b3772f9e5","addTime":1583292499,"addWording":"1","remark":"y","addSource":"",'
        '"profile":{"nickname":"Andy","avatar":"https://1.gravatar.com/avatar/a3e54af3cb6e157e496ae430aed4f4a3?s=96&d=mm","gender":0,'
        '"birthday":1583292499,"role":0,"gender":1,"level":1,"language":1,'
        '"allowType":1,"customInfo":{}},"groups":[],"customInfo":{} }]';*/

    // 先尝试从本地加载
    String result = "[ ";
    Friend friend = new Friend();
    var list = await friend.selectSome(limit: 100, offset: 0);
    if (list.length > 0) {
      for (var f in list) {
        result += sprintf(
            '{"userId": "%s", "addTime":1583292499,"addWording":"1","addSource":"",'
                '"profile":{"nickname":"%s","avatar":"%s","gender":0,'
                '"birthday":1583292499,"role":0,"gender":1,"level":1,"language":1,'
                '"allowType":1,"customInfo":{}},"groups":[],"customInfo":{},"remark":"" },',
            [f.id, f.nickName, f.avatar]);
      }
      result = result.substring(0, result.length - 1) + ']';
    } else {
      // 从网络加载
      var res = await GET("/friends?page=1&size=2&sort_name=created&sort_order=false");
      String str = res.toString();

      if (str.contains('list')) {
        var list = json.decode(str)['list'];
        for( var f in list ) {
          result += sprintf(
              '{"userId": "%s", "addTime":1583292499,"addWording":"1","addSource":"",'
                  '"profile":{"nickname":"%s","avatar":"%s","gender":0,'
                  '"birthday":1583292499,"role":0,"gender":1,"level":1,"language":1,'
                  '"allowType":1,"customInfo":{}},"groups":[],"customInfo":{},"remark":"%s" },',
              [f['_id'], f['nickname'], f['avatar'], f['description']]);

          // 写入本地数据库
          friend.nickName = f['nickname'];
          friend.avatar = f['avatar'];
          friend.id = f['_id'];
          await friend.insert(friend);
        }
        result = result.substring(0, result.length - 1) + ']';
      } else {
        debugPrint('获取好友列表  失败，返回 ' + result);
      }
    }
    return result;
  } on PlatformException {
    debugPrint('获取好友列表  失败');
  }
}
