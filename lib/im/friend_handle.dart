import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../ui/dialog/show_toast.dart';
import '../common/route.dart';

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

Future<dynamic> getContactsFriends(String userName) async {
  try {
    //var result = await im.listFriends(userName);
    var result = '[{"identifier":"1","addTime":1583292499,"addWording":"1","remark":"",'
        '"profile":{"nickname":"Jacky","avatar":"","gender":0,'
        '"birthday":1583292499,"avatar":"http://cdn.duitang.com/uploads/item/201409/18/20140918141220_N4Tic.thumb.700_0.jpeg",'
        '"identifier":"","role":0,"gender":1,"level":1,"language":1,'
        '"allowType":1,'
        '"customInfo":{}},"groups":[],"customInfo":{} }]'; // identifier
    return result;
  } on PlatformException {
    debugPrint('获取好友列表  失败');
  }
}
