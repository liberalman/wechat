import '../../im/model/chat_data.dart';
import '../massage/wait1.dart';
import '../view/indicator_page_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// 聊天框
class ChatDetailsBody extends StatelessWidget {
  final ScrollController scrollController;
  final List<ChatData> chatData;

  ChatDetailsBody({this.scrollController, this.chatData});

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: new ScrollConfiguration(
        behavior: MyBehavior(),
        child: new ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (context, int index) {
            ChatData model = chatData[index];
            return new SendMessageView(model); // 消息输入框
          },
          itemCount: chatData.length,
          dragStartBehavior: DragStartBehavior.down,
        ),
      ),
    );
  }
}
