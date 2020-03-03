import 'dart:convert';

import '../../im/entity/i_person_info_entity.dart';
import '../../im/entity/person_info_entity.dart';
import '../../im/info_handle.dart';
import '../../ui/item/chat_mamber.dart';
import '../../ui/other/label_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../tools/wechat_flutter.dart';

class ChatInfoPage extends StatefulWidget {
  final String id;

  ChatInfoPage(this.id);

  @override
  _ChatInfoPageState createState() => _ChatInfoPageState();
}

class _ChatInfoPageState extends State<ChatInfoPage> {
  var model;

  bool isRemind = false;
  bool isTop = false;
  bool isDoNotDisturb = true;

  Widget buildSwitch(item) {
    return new LabelRow(
      label: item['label'],
      margin: item['label'] == '消息免打扰' ? EdgeInsets.only(top: 10.0) : null,
      isLine: item['label'] != '强提醒',
      isRight: false,
      rightW: new SizedBox(
        height: 25.0,
        child: new CupertinoSwitch(
          value: item['value'],
          onChanged: (v) {},
        ),
      ),
      onPressed: () {},
    );
  }

  List<Widget> body() {
    List switchItems = [
      {"label": '消息免打扰', 'value': isDoNotDisturb},
      {"label": '置顶聊天', 'value': isTop},
      {"label": '强提醒', 'value': isRemind},
    ];

    return [
      new ChatMamBer(model: model),
      new LabelRow(label: '查找聊天记录', margin: EdgeInsets.only(top: 10.0)),
      new Column(
        children: switchItems.map(buildSwitch).toList(),
      ),
      new LabelRow(label: '设置当前聊天背景', margin: EdgeInsets.only(top: 10.0)),
      new LabelRow(label: '清空聊天记录', margin: EdgeInsets.only(top: 10.0)),
      new LabelRow(label: '投诉', margin: EdgeInsets.only(top: 10.0)),
    ];
  }

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  getInfo() async {
    final info = await getUsersProfile([widget.id]);
    List infoList = json.decode(info);
    setState(() {
      if(Platform.isIOS) {
        model = IPersonInfoEntity.fromJson(infoList[0]);
      }else {
        model = PersonInfoEntity.fromJson(infoList[0]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: chatBg,
      appBar: new ComMomBar(title: '聊天信息'),
      body: new SingleChildScrollView(
        child: new Column(children: body()),
      ),
    );
  }
}
