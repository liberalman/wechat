import 'package:flutter/material.dart';
import '../common/touch_callback.dart';
import '../common/wechat_item.dart';

class Personal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            color: Colors.white,
            height: 80.0,
            child: TouchCallBack(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 12.0, right: 15.0),
                    child: Image.asset('images/avatar3.jpg', width: 70.0, height: 70.0,),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('兔兔', style: TextStyle(fontSize: 18.0, color: Color(0xff353535))),
                        Text('TuTu', style: TextStyle(fontSize: 14.0, color: Color(0xffa9a9a9))),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 12.0, right: 15.0),
                    child: Image.asset('images/tabbar_me@2x.png', width: 24.0, height: 24.0,),
                  ),
                ],
              ),
              onPressed: null,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            color: Colors.white,
            child: WechatItem(title: '钱包', imagePath: 'images/tabbar_me@2x.png'),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                WechatItem(title: '收藏', imagePath: 'images/MoreMyFavorites@2x.png'),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Divider(
                    height: 0.5,
                    color: Color(0xffd9d9d9),
                  ),
                ),
                WechatItem(title: '相册', imagePath: 'images/MoreMyAlbum@2x.png'),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Divider(
                    height: 0.5,
                    color: Color(0xffd9d9d9),
                  ),
                ),
                WechatItem(title: '卡包', imagePath: 'images/MyCardPackageIcon@2x.png'),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Divider(
                    height: 0.5,
                    color: Color(0xffd9d9d9),
                  ),
                ),
                WechatItem(title: '表情', imagePath: 'images/Userguide_Emostore_icon@2x.png'),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            color: Colors.white,
            child: WechatItem(title: '设置', imagePath: 'images/MoreSetting@2x.png'),
          ),
        ],
      ),
    );
  }
}