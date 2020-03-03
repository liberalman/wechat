import '../../pages/root/user_page.dart';
import 'package:flutter/material.dart';
import '../../config/const.dart';
import '../../common/route.dart';

class HomeNullView extends StatelessWidget {
  final String str;

  HomeNullView({this.str = '无会话消息'});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new InkWell(
        child: new Text(
          str ?? '',
          style: TextStyle(color: mainTextColor),
        ),
        onTap: () => routePush(new UserPage()),
      ),
    );
  }
}
