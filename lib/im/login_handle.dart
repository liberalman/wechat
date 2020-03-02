import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../ui/dialog/show_toast.dart';
import '../tools/shared_util.dart';
import '../config/keys.dart';
import '../common/route.dart';
import '../pages/root/root_page.dart';
import '../provider/global_model.dart';

Future<void> init(BuildContext context) async {
  try{
    //var result = await im.init(appId);
    var result = "{}";
    debugPrint('初始化结果 ======>   ${result.toString()}');
  } on PlatformException {
    showToast(context, "initial failed");
  }
}

// 登录
Future<void> login(BuildContext context, String userName) async {
  final model = Provider.of<GlobalModel>(context);

  try {
    //var result = await im.imLogin(userName, null);
    var result = "ucc";
    if (result.toString().contains('ucc')) {
      model.account = userName;
      model.goToLogin = false;
      await SharedUtil.getInstance().saveString(Keys.account, userName);
      await SharedUtil.getInstance().saveBoolean(Keys.hasLogged, true);
      model.refresh();
      await routePushAndRemove(new RootPage());
    } else {
      print('error::' + result.toString());
    }
  } on PlatformException {
    showToast(context, '你已登录或者其他错误');
  }
}