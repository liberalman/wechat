import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wechat/config/const.dart';
import 'package:wechat/im/model/chat_data.dart';
import './config/storage_manager.dart';
import './chat/message_page.dart';
import './contacts/contacts.dart';
import './found/found.dart';
import './person/personal.dart';
import './provider/global_model.dart';
import './provider/conversation_model.dart';
import './generated/i18n.dart';
import './pages/login/login_begin_page.dart';
import './pages/root/root_page.dart';
import './common/route.dart';
import './mqtt/mqtt_server_client.dart';
import './mqtt/event_bus.dart';

// 右上角点击➕号后弹出的菜单项
enum ItemType { GroupChat, AddFrinds, QrCode, Payments, Help }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      StorageManager().initAutoLogin();
    } else {
      debugPrint('IOS自动登陆开发中');
    }
    Mqtt.getInstance(); // 初始化mqtt。连接远程服务器
  }

  @override
  Widget build(BuildContext context) {
    // 使用Provider设置GlobalModel的值，初始化语言什么的
    final model = Provider.of<GlobalModel>(context)..setContext(context);

    return new MaterialApp(
      navigatorKey: navGK, // 做导航用的全局key，存储的是导航条状态
      title: model.appName,
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        hintColor: Colors.grey.withOpacity(0.3), // hint提示，Opacity不透明性
        splashColor: Colors.transparent, // splash光斑static final String appName = "app_name";
        canvasColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      // 国际化配置
      localizationsDelegates: [
        S.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: model.currentLocale,
      // 若已登录，则转到登录后的根视图页面；否则跳转需要登录注册的页面
      home: model.goToLogin ? new LoginBeginPage() : new RootPage(),
    );
  }

/*
  var _currentIndex = 3;

  MessagePage message; // 微信消息页
  Contacts contacts; // 通讯录
  Found found; // 发现
  Personal me; // 我

  // 不同底层页面切换的动作
  currentPage() {
    switch (_currentIndex) {
      case 0:
        if (message == null) {
          message = new MessagePage();
        }
        return message;
      case 1:
        if (contacts == null) {
          contacts = new Contacts();
        }
        return contacts;
    case 2:
        if (found == null) {
          found = new Found();
        }
        return found;
    case 3:
        if (me == null) {
          me = new Personal();
        }
        return me;
    }
  }

  // 弹出菜单绘制函数
  _popupMenuItem(String title, {String imagePath, IconData icon}) {
    return PopupMenuItem(
      child: Row(
        children: <Widget>[
          imagePath != null
              ? Image.asset(imagePath, width: 32.0, height: 32.0)
              : SizedBox(
                  width: 32.0,
                  height: 32.0,
                  child: Icon(icon, color: Colors.white)),
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 右上角导航栏
      appBar: AppBar(
        title: Text('微信'),
        actions: <Widget>[
          // 搜索框按钮
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'search');
            },
            child: Icon(
              Icons.search,
            ),
          ),
          // 右上角➕号弹出菜单
          Padding(
            // 设置菜单弹出后显示的内部间距
            padding: const EdgeInsets.only(left: 30.0, right: 20.0),
            child: GestureDetector(
              onTap: () {
                showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(500.0, 76.0, 10.0, 0.0),
                    // 设置菜单绘制区域矩形
                    items: <PopupMenuEntry>[
                      _popupMenuItem('发起群聊',
                          imagePath: 'images/contacts_add_newmessage@2x.png'),
                      _popupMenuItem('添加朋友',
                          imagePath: 'images/contacts_add_friend@2x.png'),
                      _popupMenuItem('扫一扫',
                          imagePath: 'images/contacts_add_scan@2x.png'),
                      _popupMenuItem('收付款', icon: Icons.crop_free),
                      _popupMenuItem('帮助与反馈', icon: Icons.email),
                    ]);
              },
              //child: Icon(Icons.add),
              child: ImageIcon(AssetImage(
                  'images/TypeSelectorBtn_Black@2x.png')), // 这里用➕图片代替原本用默认字体的➕号。
              //child: ImageIcon(AssetImage('images/TypeSelectorBtn_Black@2x.png'),size: 50,color: Colors.red,), // 这里用➕图片代替原本用默认字体的➕号。
            ),
          ),
        ],
      ),
      // 底部导航栏，页面4个按钮
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: ((index) {
          setState(() {
            _currentIndex = index;
          });
        }),
        items: [
          new BottomNavigationBarItem(
              title: new Text(
                '微信',
                style: TextStyle(
                    color: _currentIndex == 0
                        ? Color(0xFF46c01b)
                        : Color(0xff999999)),
              ),
              icon: _currentIndex == 0
                  ? Image.asset('images/tabbar_mainframeHL@2x.png',
                      width: 32.0, height: 28.0)
                  : Image.asset('images/tabbar_mainframe@2x.png',
                      width: 32.0, height: 28.0)),
          new BottomNavigationBarItem(
              title: new Text(
                '通讯录',
                style: TextStyle(
                    color: _currentIndex == 1
                        ? Color(0xFF46c01b)
                        : Color(0xff999999)),
              ),
              icon: _currentIndex == 1
                  ? Image.asset('images/tabbar_contactsHL@2x.png',
                      width: 32.0, height: 28.0)
                  : Image.asset('images/tabbar_contacts@2x.png',
                      width: 32.0, height: 28.0)),
          new BottomNavigationBarItem(
              title: new Text(
                '发现',
                style: TextStyle(
                    color: _currentIndex == 2
                        ? Color(0xFF46c01b)
                        : Color(0xff999999)),
              ),
              icon: _currentIndex == 2
                  ? Image.asset('images/tabbar_discoverHL@2x.png',
                      width: 32.0, height: 28.0)
                  : Image.asset('images/tabbar_discover@2x.png',
                      width: 32.0, height: 28.0)),
          new BottomNavigationBarItem(
              title: new Text(
                '我',
                style: TextStyle(
                    color: _currentIndex == 3
                        ? Color(0xFF46c01b)
                        : Color(0xff999999)),
              ),
              icon: _currentIndex == 3
                  ? Image.asset('images/tabbar_meHL@2x.png',
                      width: 32.0, height: 28.0)
                  : Image.asset('images/tabbar_me@2x.png',
                      width: 32.0, height: 28.0)),
        ],
      ),
      body: currentPage(),
    );
  }*/
}
