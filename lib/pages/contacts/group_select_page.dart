import 'package:flutter/material.dart';

import '../../ui/bar/common_bar.dart';
import '../../config/const.dart';

class GroupSelectPage extends StatefulWidget {
  @override
  _GroupSelectPageState createState() => _GroupSelectPageState();
}

class _GroupSelectPageState extends State<GroupSelectPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new ComMomBar(title: '选择群聊'),
      body: new Center(
        child: new Text(
          '暂无群聊',
          style: TextStyle(color: mainTextColor),
        ),
      ),
    );
  }
}
