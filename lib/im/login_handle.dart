import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../ui/dialog/show_toast.dart';
import '../tools/shared_util.dart';
import '../config/keys.dart';
import '../common/route.dart';
import '../pages/root/root_page.dart';
import '../provider/global_model.dart';
import '../pages/login/login_begin_page.dart';
import '../tools/wechat_flutter.dart';
import '../http/api.dart';

Future<void> init(BuildContext context) async {
  try {
    //var result = await im.init(appId);
    var result = "{}";
    debugPrint('初始化结果 ======>   ${result.toString()}');
  } on PlatformException {
    showToast(context, "initial failed");
  }
}

// 登录
Future<void> login(BuildContext context, String account) async {
  final model = Provider.of<GlobalModel>(context);

  try {
    /*
        // 返回示例
{
    "accessToken": "691cbf3beb8b3449ebc165ea41ddade855528146",
    "accessTokenExpiresAt": "2020-03-13T04:50:20.835Z",
    "refreshToken": "5f23f967b61c33f2b20d6035ec36be2ccb70c474",
    "refreshTokenExpiresAt": "2020-03-27T03:50:20.836Z",
    "createAt": "2020-03-06T04:50:20.835Z",
    "client": {
        "id": "web"
    },
    "user": {
        "userId": "5c566802128c810b3772f9e5",
        "name": "Andy",
        "email": "test@test.com",
        "avatar": "https://1.gravatar.com/avatar/a3e54af3cb6e157e496ae430aed4f4a3?s=96&d=mm"
    }
}
        */
    var res = await POST_WITHOUT_LOGIN("/user/login",
        formData: {
          "grant_type": "password",
          "username": account,
          "password": "123456",
          "client_id": "web",
          "client_secret": "fskefgtarwdbawydrawpdpaiuiawdtg"
        }
    );
    String result = res.toString();

    if (result.contains('accessToken')) {
      var obj = json.decode(result);
      model.nickName = obj['user']['name'];
      model.account = obj['user']['email'];
      model.userId = obj['user']['userId'];
      model.accessToken = obj['accessToken'];
      model.avatar = obj['user']['avatar'];
      model.goToLogin = false;
      await SharedUtil.getInstance().saveString(Keys.accessToken, model.accessToken);
      await SharedUtil.getInstance().saveString(Keys.account, model.account);
      await SharedUtil.getInstance().saveString(Keys.userId, model.userId);
      await SharedUtil.getInstance().saveBoolean(Keys.hasLogged, true);
      model.refresh(); // 刷新用户数据
      await routePushAndRemove(new RootPage()); // 返回主页
    } else {
      showToast(context, 'error::' + result);
    }
  } on PlatformException {
    showToast(context, '你已登录或者其他错误');
  }
}

Future<void> loginOut(BuildContext context) async {
  final model = Provider.of<GlobalModel>(context);

  try {
    var res = await POST("/user/logout");
    String result = res.toString();
    if (result.contains('{}')) {
      showToast(context, '登出成功');
    } else {
      showToast(context, 'error::' + result);
    }
    model.goToLogin = true;
    model.refresh();
    await SharedUtil.getInstance().saveBoolean(Keys.hasLogged, false);
    await routePushAndRemove(new LoginBeginPage());
  } on PlatformException {
    model.goToLogin = true;
    model.refresh();
    await SharedUtil.getInstance().saveBoolean(Keys.hasLogged, false);
    await routePushAndRemove(new LoginBeginPage());
  }
}
