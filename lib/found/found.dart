import 'package:flutter/material.dart';
import '../common/wechat_item.dart';

class Found extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<Found> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
          child: ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                color: Colors.white,
                child: WechatItem(imagePath: 'images/Action_Moments@2x.png', title: '朋友圈'),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    WechatItem(imagePath: 'images/contacts_add_scan@2x.png', title: '扫一扫'),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Divider(
                        height: 0.5,
                        color: Color(0xffd9d9d9),
                      ),
                    ),
                    WechatItem(imagePath: 'images/contacts_add_shake@2x.png', title: '摇一摇'),
                  ],

                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    WechatItem(imagePath: 'images/contacts_add_shake@2x.png', title: '看一看'),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Divider(
                        height: 0.5,
                        color: Color(0xffd9d9d9),
                      ),
                    ),
                    WechatItem(imagePath: 'images/contacts_add_shake@2x.png', title: '搜一搜'),
                  ],

                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    WechatItem(imagePath: 'images/contacts_add_shake@2x.png', title: '附近的人'),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Divider(
                        height: 0.5,
                        color: Color(0xffd9d9d9),
                      ),
                    ),
                    WechatItem(imagePath: 'images/contacts_add_shake@2x.png', title: '漂流瓶'),
                  ],

                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    WechatItem(imagePath: 'images/contacts_add_shake@2x.png', title: '购物'),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Divider(
                        height: 0.5,
                        color: Color(0xffd9d9d9),
                      ),
                    ),
                    WechatItem(imagePath: 'images/Userguide_Gamecenter_icon@2x.png', title: '游戏'),
                  ],

                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                color: Colors.white,
                child: WechatItem(imagePath: 'images/contacts_add_shake@2x.png', title: '小程序'),
              ),
            ],
          ),
        )
    );
  }
}