import '../../im/model/chat_data.dart';
import './msg_avatar.dart';
import 'package:flutter/material.dart';
import './text_item_container.dart';
import 'package:provider/provider.dart';

import '../../provider/global_model.dart';
import '../view/image_view.dart';

class TextMsg extends StatelessWidget {
  final String text;
  final ChatData model;

  TextMsg(this.text, this.model);

  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);
    var body = [
      new MsgAvatar(model: model, globalModel: globalModel), // 每条消息的头像
      new TextItemContainer( // 消息条显示
        text: text ?? '文字为空',
        action: '',
        isMyself: model.userId == globalModel.account,
      ),
      new Spacer(),
    ];
    if (model.userId == globalModel.userId) { //检查消息是不是自己发的
      body = body.reversed.toList();
    } else {
      body = body;
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: new Row(children: body),
    );
  }
}
