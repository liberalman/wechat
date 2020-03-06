import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../config/const.dart';
import '../../ui/bar/common_bar.dart';
import '../../ui/button/common_button.dart';
import '../../ui/view/main_input.dart';
import '../../ui/ui.dart';
import '../../ui/dialog/show_toast.dart';
import '../../provider/login_model.dart';
import '../../generated/i18n.dart';
import '../../common/route.dart';
import '../../config/keys.dart';
import '../../tools/shared_util.dart';
import '../../pages/login/select_location_page.dart';
import '../../im/login_handle.dart';

// 登录页，显示输入手机号，选择国家等
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    initEdit();
  }

  initEdit() async {
    final account = await SharedUtil.getInstance().getString(Keys.account);
    //_textEditingController.text = account ?? '';
    _textEditingController.text = 'test@test.com';
  }

  Widget body(LoginModel model) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(
              left: 20.0, top: mainSpace * 3, bottom: mainSpace * 2),
          child: new Text(
            S.of(context).mobileNumberLogin,
            style: TextStyle(fontSize: 25.0),
          ),
        ),
        new FlatButton(
          child: new Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: new Row(
              children: <Widget>[
                new Container(
                  //width: winWidth(context) * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25, // 窗口宽度*0.25
                  alignment: Alignment.centerLeft,
                  child: new Text(S.of(context).phoneCity,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w400)),
                ),
                new Expanded(
                  child: new Text(
                    model.area,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
          onPressed: () async {
            // 选择手机号归属国家
            final result = await routePush(new SelectLocationPage());
            if (result == null) return;
            model.area = result;
            model.refresh();
            SharedUtil.getInstance().saveString(Keys.area, result);
          },
        ),
        new Container(
          padding: EdgeInsets.only(bottom: 5.0),
          decoration: BoxDecoration(
              border:
              Border(bottom: BorderSide(color: Colors.grey, width: 0.15))),
          child: new Row(
            children: <Widget>[
              new Container(
                width: MediaQuery.of(context).size.width * 0.25,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 25.0),
                child: new Text(
                  S.of(context).phoneNumber,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                ),
              ),
              new Expanded(
                  child: new TextField(
                    controller: _textEditingController,
                    maxLines: 1,
                    style: TextStyle(textBaseline: TextBaseline.alphabetic),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(new RegExp('[0-9]'))
                    ],
                    decoration: InputDecoration(
                        hintText: S.of(context).phoneNumberHint,
                        border: InputBorder.none),
                    onChanged: (text) {
                      setState(() {});
                    },
                  ))
            ],
          ),
        ),
        new Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: new InkWell(
            child: new Text(
              S.of(context).userLoginTip,
              style: TextStyle(color: tipColor),
            ),
            onTap: () => showToast(context, S.of(context).notOpen),
          ),
        ),
        new Space(height: mainSpace * 2.5),
        new ComMomButton(
          text: S.of(context).nextStep,
          style: TextStyle(
              color:
              _textEditingController.text == '' ? Colors.grey.withOpacity(0.8) : Colors.white),
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          color: _textEditingController.text == ''
              ? Color.fromRGBO(226, 226, 226, 1.0)
              : Color.fromRGBO(8, 191, 98, 1.0),
          onTap: () {
            if (_textEditingController.text == '') {
              showToast(context, '随便输入三位或以上');
            } else if (_textEditingController.text.length >= 3) {
              // 正式执行登录操作，链接后台服务器验证，成功则返回用户信息
              login(context, _textEditingController.text);
            } else {
              showToast(context, '请输入三位或以上');
            }
          },
        ),
      ],
    );
  }

  Widget bottomItem(item) {
    return new Row(
      children: <Widget>[
        new InkWell(
          child: new Text(item, style: TextStyle(color: tipColor)),
          onTap: () {
            showToast(context, S.of(context).notOpen + item);
          },
        ),
        item == S.of(context).weChatSecurityCenter
            ? new Container()
            : new Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: new VerticalLine(height: 15.0),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('start LoginPage');
    final model = Provider.of<LoginModel>(context);
    List btItem = [
      S.of(context).retrievePW,
      S.of(context).emergencyFreeze,
      S.of(context).weChatSecurityCenter,
    ];

    return new Scaffold(
      appBar:
          new ComMomBar(title: '', leadingImg: 'assets/images/bar_close.png'),
      body: new MainInputBody(
        color: appBarColor,
        child: new Stack(
          children: <Widget>[
            new SingleChildScrollView(child: body(model)),
            new Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: btItem.map(bottomItem).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
