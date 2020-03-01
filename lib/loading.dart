import 'package:flutter/material.dart';
import 'dart:async';
import './mqtt/mqtt_server_client.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingState createState() => new _LoadingState();
}

class _LoadingState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration(seconds: 1), () {
      // app启动页，延迟3秒
      print("Flutter 高仿微信程序启动....");
      //mqtt.publishMessage("aaaaaaa");
      Navigator.of(context).pushReplacementNamed("app"); // 将app.dart推入
    });
    Mqtt mqtt = Mqtt.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Image.asset("images/loading.jpg"), // 启动页照片
    );
  }
}
