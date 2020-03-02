import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/global_model.dart';
import '../../ui/button/common_button.dart';
import '../../generated/i18n.dart';
import '../../config/const.dart';
import '../../config/provider_config.dart';
import '../../common/route.dart';
import './login_page.dart';
import './register_page.dart';
import '../../im/login_handle.dart';
import '../../pages/settings/language_page.dart';

// 选择语言、登录、注册按钮显示页面，通过点击不同的按钮跳转到对应功能页面
class LoginBeginPage extends StatefulWidget {
  @override
  _LoginBeginPageState createState() => new _LoginBeginPageState();
}

class _LoginBeginPageState extends State<LoginBeginPage> {
  Widget body(GlobalModel model) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // 右上角的选择语言按钮
        new Container(
          alignment: Alignment.topRight,
          child: new InkWell(
            // InkWell墨水池
            child: new Padding(
              padding: EdgeInsets.all(10.0),
              child: new Text(
                S.of(context).language,
                style: TextStyle(color: Colors.white),
              ),
            ),
            onTap: () => routePush(new LanguagePage()),
          ),
        ),
        // 菜单列表
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            new ComMomButton(
              text: S.of(context).login,
              margin: EdgeInsets.only(left: 10.0),
              width: 100.0,
              // 点击按钮后，路由到新页面
              onTap: () => routePush(
                  ProviderConfig.getInstance().getLoginPage(new LoginPage())),
            ),
            new ComMomButton(
                text: S.of(context).register,
                color: bgColor,
                style: TextStyle(
                    fontSize: 15.0, color: Color.fromRGBO(8, 191, 98, 1.0)),
                margin: EdgeInsets.only(right: 10.0),
                onTap: () => routePush(ProviderConfig.getInstance()
                    .getLoginPage(new RegisterPage())),
                width: 100.0),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GlobalModel>(context); // 拿到全局配置信息

    var bodyMain = new Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bsc.webp'), // 启动页那个小人图片
              fit: BoxFit.cover)),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: body(model),
    );
    return new Scaffold(body: bodyMain);
  }

  @override
  void initState() {
    super.initState();
    init(context); // IM初始化
  }
}
