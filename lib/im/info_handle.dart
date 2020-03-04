import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../tools/wechat_flutter.dart';
import '../provider/global_model.dart';

Future<dynamic> getUsersProfile(List<String> users, {Callback callback}) async {
  try {
    //var result = await
    Map<String, String> map = {
      "1": '{"identifier":"1","nickname":"Tom","gender":0,'
          '"birthday":1583292499,"avatar":"http://cdn.duitang.com/uploads/item/201409/18/20140918141220_N4Tic.thumb.700_0.jpeg",'
          '"role":0,"gender":0,"level":1,"language":1,'
          '"allowType":1,'
          '"customInfo":{}}',
      '2': '{"identifier":"2","nickname":"Andy","gender":1,'
          '"birthday":1583292499,"avatar":"https://www.xiziwang.net/uploads/allimg/171018/742_171018131028_1.jpg",'
          '"role":0,"gender":1,"level":1,"language":1,'
          '"allowType":1,'
          '"customInfo":{}}',
      '3': '{"identifier":"3","nickname":"Jacky","gender":0,"birthday":1583292499,'
          '"avatar":"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2114530898,1006433171&fm=26&gp=0.jpg",'
          '"role":0,"level":1,"language":1,'
          '"allowType":1,"customInfo":{}}'
    };
    String str = "[ ";
    for (var id in users) {
      str += map[id] + ",";
    }
    return str.substring(0, str.length - 1) + ']';
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
