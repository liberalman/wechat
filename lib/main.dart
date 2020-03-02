import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import './config/storage_manager.dart';
import './config/provider_config.dart';
import './app.dart';
import './loading.dart';
import './search.dart';

void main() async {
  // ensure initialized
  WidgetsFlutterBinding.ensureInitialized();

  // initial configuration
  await StorageManager.init();

  // 载入APP入口，并配置Provider进行状态管理
  // 我们要监听改变就要在MyApp()外面套一层，这个是全局的
  runApp(ProviderConfig.getInstance().getGlobal(MyApp()));

  // 自定义报错页面
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    debugPrint(flutterErrorDetails.toString());
    return new Center(
        child: new Text("App something error, please connect to auther!"));
  };

  // Android Status Bar transparent
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

/*void main1() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'wechat',
      theme: mDefaultTheme,
      routes: <String, WidgetBuilder>{
        // 路由
        "app": (BuildContext context) => new MyApp(),
        "/friends": (_) => new WebviewScaffold(
              url: "https://weixin.qq.com",
              appBar: new AppBar(title: new Text("微信朋友圈")),
              withZoom: true,
              withLocalStorage: true,
            ),
        'search': (BuildContext context) => new Search(),
      },
      home: new LoadingPage(), // 加载启动图片和主页
    ));

final ThemeData mDefaultTheme = new ThemeData(
  //primaryColor: Color(0xff303030),
  primaryColor: Color(0xFFebebeb),
  scaffoldBackgroundColor: Color(0xFFebebeb),
  cardColor: Color(0xff393a3f),
);
*/