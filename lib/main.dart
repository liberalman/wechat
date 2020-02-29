import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import './app.dart';
import './loading.dart';
import './search.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'wechat',
      theme: mDefaultTheme,
      routes: <String, WidgetBuilder>{
        // 路由
        "app": (BuildContext context) => new App(),
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
