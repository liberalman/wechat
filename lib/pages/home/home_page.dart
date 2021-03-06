import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';

import '../../config/const.dart';
import '../../tools/wechat_flutter.dart';
import '../../ui/view/indicator_page_view.dart';
import '../../ui/edit/text_span_builder.dart';
import '../../ui/chat/my_conversation_view.dart';
import '../../ui/view/pop_view.dart';
import '../../ui/view/null_view.dart';
import '../../config/contacts.dart';
import '../../common/route.dart';
import '../../mqtt/event_bus.dart';
import '../../im/conversation_handle.dart';
import '../../im/model/chat_list.dart';
import '../../im/model/chat_data.dart';
import '../../im/entity/i_person_info_entity.dart';
import '../../im/message_handle.dart';
import '../../im/info_handle.dart';
import '../chat/chat_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<ChatList> _chatData = [];

  var tapPos;
  var isNull = false;
  TextSpanBuilder _builder = TextSpanBuilder();
  StreamSubscription<dynamic> _messageStreamSubscription;
  String userId;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getChatData();
  }

  Future getChatData() async {
    final str = await ChatListData().chatListData();
    isNull = await ChatListData().isNull();

    List<ChatList> listChat = str;
    _chatData.clear();
    _chatData..addAll(listChat.reversed);
    if (mounted) setState(() {});
  }

  _showMenu(BuildContext context, Offset tapPos, int type, String id) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromLTRB(tapPos.dx, tapPos.dy,
        overlay.size.width - tapPos.dx, overlay.size.height - tapPos.dy);
    showMenu<String>(
        context: context,
        position: position,
        items: <MyPopupMenuItem<String>>[
          new MyPopupMenuItem(child: Text('标为已读'), value: '标为已读'),
          new MyPopupMenuItem(child: Text('置顶聊天'), value: '置顶聊天'),
          new MyPopupMenuItem(child: Text('删除该聊天'), value: '删除该聊天'),
          // ignore: missing_return
        ]).then<String>((String selected) {
      switch (selected) {
        case '删除该聊天':
          deleteConversationAndLocalMsgModel(type, id, callback: (str) {
            debugPrint('deleteConversationAndLocalMsgModel' + str.toString());
          });
          delConversationModel(id, type, callback: (str) {
            debugPrint('deleteConversationModel' + str.toString());
          });
          getChatData();
          break;
        case '标为已读':
          getUnreadMessageNumModel(type, id, callback: (str) {
            int num = int.parse(str.toString());
            if (num != 0) {
              setReadMessageModel(type, id);
              setState(() {});
            }
          });
          break;
      }
    });
  }

  void canCelListener() {
    if (_messageStreamSubscription != null) {
      _messageStreamSubscription.cancel();
    }
  }

  Future<void> initPlatformState() async {
    userId = await SharedUtil.getInstance().getString(Keys.userId);
    if (!mounted)
      return;

    if (_messageStreamSubscription == null) {
      //_messageStreamSubscription =
      //    im.onMessage.listen((dynamic onData) => getChatData());
      _messageStreamSubscription = eventBus.on<ChatEvent>().listen((event) {
        // 监听从远程mqtt服务器下发的消息
        addMessage(event.sender, event.roomId, event.content);

        getUserProfile(event.roomId).then((value){  // 根据发送者id查询他的详情，注意，实际消息的发送者就是roomId。
          IPersonInfoEntity model = IPersonInfoEntity.fromJson(json.decode(value));

          /*_chatData[''].insert(
              0,
              new ChatData( // 必须把详情补全，否则将来在显示页面的时候，因为上游数据缺失，传递到最底层 msg_avatar.dart中的数据也缺了，导致无法正常显示聊天页面。
                  userId: model.userId,
                  nickName: model.nickname,
                  avatar: model.avatar,
                  time: DateTime.now().millisecondsSinceEpoch,
                  msg: {"text": event.content}));*/
          if (mounted) setState(() {});
        });
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  Widget timeView(int time) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);

    String hourParse = "0${dateTime.hour}";
    String minuteParse = "0${dateTime.minute}";

    String hour = dateTime.hour.toString().length == 1
        ? hourParse
        : dateTime.hour.toString();
    String minute = dateTime.minute.toString().length == 1
        ? minuteParse
        : dateTime.minute.toString();

    String timeStr = '$hour:$minute';

    return new SizedBox(
      width: 35.0,
      child: new Text(
        timeStr,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: mainTextColor, fontSize: 14.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (isNull) return new HomeNullView();
    return new Container(
      color: Color(AppColors.BackgroundColor),
      child: new ScrollConfiguration(
        behavior: MyBehavior(),
        child: new ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            ChatList model = _chatData[index];

            return InkWell(
              onTap: () {
                routePush(new ChatPage(
                    peer: model.userId,
                    title: model.name,
                    type: model.type == 'Group' ? 2 : 1));
              },
              onTapDown: (TapDownDetails details) {
                tapPos = details.globalPosition;
              },
              onLongPress: () {
                if (Platform.isAndroid) {
                  _showMenu(context, tapPos, model.type == 'Group' ? 2 : 1,
                      model.userId);
                } else {
                  debugPrint("IOS聊天长按选项功能开发中");
                }
              },
              child: new MyConversationView(
                avatar: model.avatar,
                title: model?.name ?? '',
                content: model?.content,
                time: timeView(model?.time ?? 0),
                isBorder: model?.name != _chatData[0].name,
              ),
            );
          },
          itemCount: _chatData?.length ?? 1,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    canCelListener();
  }
}
