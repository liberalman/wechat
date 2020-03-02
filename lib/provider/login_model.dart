import 'package:flutter/material.dart';
import './logic/login_logic.dart';

class LoginModel extends ChangeNotifier {
  BuildContext context;
  String area = "中国大陆（+86）";
  LoginLogic logic;

  LoginModel() {
    logic = LoginLogic(this);
    // 等待获取到手机号所在区域后，再处理通知使用该model的widget刷新数据
    Future.wait([logic.getArea()]).then((value) {
      refresh();
    });
  }

  void refresh() {
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("LoginLogic销毁了");
  }
}