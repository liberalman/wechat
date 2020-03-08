import 'dart:async';
import 'dart:convert';
import 'package:sprintf/sprintf.dart';
import 'package:flutter/material.dart';
import 'package:wechat/config/provider_config.dart';
import 'package:wechat/im/all_im.dart';
import '../../im/model/chat_data.dart';
import './chat_more_page.dart';
import '../../ui/chat/chat_details_body.dart';
import '../../ui/chat/chat_details_row.dart';
import '../../ui/item/chat_more_icon.dart';
import '../../ui/view/indicator_page_view.dart';
import '../../ui/view/main_input.dart';
import '../../ui/bar/common_bar.dart';

//import 'package:extended_text_field/extended_text_field.dart';
import '../../im/send_handle.dart';
import '../../tools/wechat_flutter.dart';
import '../../ui/edit/text_span_builder.dart';
import '../../config/contacts.dart';
import 'chat_info_page.dart';
import '../../common/route.dart';
import '../../tools/data/notice.dart';
import '../../tools/data/data.dart';
import '../../config/const.dart';
import '../../mqtt/event_bus.dart';
import '../../mqtt/mqtt_server_client.dart';
import '../../provider/global_model.dart';
import 'package:provider/provider.dart';
import '../../im/info_handle.dart';
import '../../im/entity/i_person_info_entity.dart';

enum ButtonType { voice, more }

class ChatPage extends StatefulWidget {
  final String title;
  final int type;
  final String peer;

  ChatPage({this.peer, this.title, this.type = 1});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatData> chatData = [];
  StreamSubscription<dynamic> _msgStreamSubs;
  bool _isVoice = false;
  bool _isMore = false;
  double keyboardHeight = 270.0;
  String sender = '';

  TextEditingController _textController = TextEditingController();
  FocusNode _focusNode = new FocusNode();
  ScrollController scrollController = ScrollController();
  PageController pageC = new PageController();

  @override
  void initState() {
    super.initState();
    getChatMsgData();

    scrollController.addListener(
        () => FocusScope.of(context).requestFocus(new FocusNode()));
    initPlatformState();
    Notice.addListener(WeChatActions.msg(), (v) => getChatMsgData());
  }

  Future<void> initPlatformState() async {
    if (!mounted)
      return;

    // 用以下命令测试往当前用户发送消息，看看监听是否有效
    // mosquitto_pub -h 140.143.134.114 -p 1883 -t "C2C/5c566802128c810b3772f9e5" -q 1 -m "{\"sender\":\"2\",\"content\":\"yes,i know\"}"
    //订阅eventbus
    if (_msgStreamSubs == null) {
      //_msgStreamSubs = im.onMessage.listen((dynamic onData) => getChatMsgData());
      _msgStreamSubs = eventBus.on<ChatEvent>().listen((event) {
        // 监听从远程mqtt服务器下发的消息
        _textController.clear();
        addMessage(event.sender, event.roomId, event.content);

        getUserProfile(event.roomId).then((value){  // 根据发送者id查询他的详情，注意，实际消息的发送者就是roomId。
          IPersonInfoEntity model = IPersonInfoEntity.fromJson(json.decode(value));

          chatData.insert(
              0,
              new ChatData( // 必须把详情补全，否则将来在显示页面的时候，因为上游数据缺失，传递到最底层 msg_avatar.dart中的数据也缺了，导致无法正常显示聊天页面。
                  userId: model.userId,
                  nickName: model.nickname,
                  avatar: model.avatar,
                  time: DateTime.now().millisecondsSinceEpoch,
                  msg: {"text": event.content}));
          if (mounted) setState(() {});
        });
      });
    }
  }

  Future getChatMsgData() async {
    // 如果是一对一聊天，则直接使用对方的用户id作为房间号，这样好识别。
    final str = await ChatDataRep().repData(widget.peer, widget.type);
    List<ChatData> listChat = str;
    chatData.clear();
    chatData..addAll(listChat.reversed);
    if (mounted) setState(() {});
  }

  void canCelListener() {
    // 由于EventBus其核心是基于Dart Streams（流）,因此退出页面时要取消订阅，防止内存泄漏
    if (_msgStreamSubs != null) _msgStreamSubs.cancel();
  }

  _handleSubmittedData(String text) async {
    _textController.clear();

    final info = await getUserProfile(sender); // 根据发送者id查询他的详情
    IPersonInfoEntity model = IPersonInfoEntity.fromJson(json.decode(info));

    chatData.insert(
        0,
        new ChatData(
            userId: model.userId,
            nickName: model.nickname,
            avatar: model.avatar,
            time: DateTime.now().millisecondsSinceEpoch,
            msg: {"text": text}));
    if (mounted) setState(() {});
    await sendTextMsg(sender, '${widget.peer}', widget.type, text); // 这个是显示在屏幕上
  }

  onTapHandle(ButtonType type) {
    setState(() {
      if (type == ButtonType.voice) {
        _focusNode.unfocus();
        _isMore = false;
        _isVoice = !_isVoice;
      } else {
        _isVoice = false;
        if (_focusNode.hasFocus) {
          _focusNode.unfocus();
          _isMore = true;
        } else {
          _isMore = !_isMore;
        }
      }
    });
  }

  Widget edit(context, size) {
    // 计算当前的文本需要占用的行数
    TextSpan _text =
        TextSpan(text: _textController.text, style: AppStyles.ChatBoxTextStyle);

    TextPainter _tp = TextPainter(
        text: _text,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left);
    _tp.layout(maxWidth: size.maxWidth);

//    return ExtendedTextField(
//      specialTextSpanBuilder: TextSpanBuilder(showAtBackground: true),
//      onTap: () => setState(() {}),
//      onChanged: (v) => setState(() {}),
//      decoration: InputDecoration(
//          border: InputBorder.none, contentPadding: const EdgeInsets.all(5.0)),
//      controller: _textController,
//      focusNode: _focusNode,
//      maxLines: 99,
//      cursorColor: const Color(AppColors.ChatBoxCursorColor),
//      style: AppStyles.ChatBoxTextStyle,
//    );
    return TextField(
      controller: _textController,
      focusNode: _focusNode,
      maxLines: 99,
      cursorColor: const Color(AppColors.ChatBoxCursorColor),
      decoration: InputDecoration(
          border: InputBorder.none, contentPadding: const EdgeInsets.all(5.0)),
      onTap: () => setState(() {}),
      onChanged: (v) => setState(() {}),
      style: AppStyles.ChatBoxTextStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GlobalModel>(context);
    sender = model.userId;
    if (keyboardHeight == 270.0 &&
        MediaQuery.of(context).viewInsets.bottom != 0) {
      keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    }
    var body = [
      chatData != null
          ? new ChatDetailsBody(
              scrollController: scrollController, chatData: chatData) // 创建聊天框界面
          : new Spacer(),
      new ChatDetailsRow(
        // 底部banner栏
        voiceOnTap: () => onTapHandle(ButtonType.voice),
        isVoice: _isVoice,
        edit: edit,
        more: new ChatMoreIcon(
          // 底部那个输入框栏
          value: _textController.text,
          onTap: () => _handleSubmittedData(_textController.text), // 发送消息
          moreTap: () => onTapHandle(ButtonType.more),
        ),
        id: widget.peer,
        type: widget.type,
      ),
      new Container(
        // more弹出栏
        height: _isMore && !_focusNode.hasFocus ? keyboardHeight : 0.0,
        width: MediaQuery.of(context).size.width,
        color: Color(AppColors.ChatBoxBg),
        child: new IndicatorPageView(
          pageC: pageC,
          pages: List.generate(2, (index) {
            return new ChatMorePage(
              index: index,
              id: widget.peer,
              type: widget.type,
              keyboardHeight: keyboardHeight,
            );
          }),
        ),
      ),
    ];

    var rWidget = [
      new InkWell(
        child: new Image.asset('assets/images/right_more.png'),
        onTap: () => routePush(new ChatInfoPage(widget.peer)),
      )
    ];

    return Scaffold(
      appBar: new ComMomBar(title: widget.title, rightDMActions: rWidget),
      body: new MainInputBody(
        onTap: () => setState(() => _isMore = false),
        decoration: BoxDecoration(color: chatBg),
        child: new Column(children: body),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    canCelListener();
    scrollController.dispose();
  }
}
