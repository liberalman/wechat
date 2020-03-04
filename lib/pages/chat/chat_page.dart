import 'dart:async';
import '../../im/model/chat_data.dart';
import './chat_more_page.dart';
import '../../ui/chat/chat_details_body.dart';
import '../../ui/chat/chat_details_row.dart';
import '../../ui/item/chat_more_icon.dart';
import '../../ui/view/indicator_page_view.dart';
import '../../ui/view/main_input.dart';
import '../../ui/bar/common_bar.dart';
//import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import '../../im/send_handle.dart';
import '../../tools/wechat_flutter.dart';
import '../../ui/edit/text_span_builder.dart';
import '../../config/contacts.dart';
import 'chat_info_page.dart';
import '../../common/route.dart';
import '../../tools/data/notice.dart';
import '../../tools/data/data.dart';
import '../../config/const.dart';

enum ButtonType { voice, more }

class ChatPage extends StatefulWidget {
  final String title;
  final int type;
  final String id;

  ChatPage({this.id, this.title, this.type = 1});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatData> chatData = [];
  StreamSubscription<dynamic> _msgStreamSubs;
  bool _isVoice = false;
  bool _isMore = false;
  double keyboardHeight = 270.0;

  TextEditingController _textController = TextEditingController();
  FocusNode _focusNode = new FocusNode();
  ScrollController scrollController = ScrollController();
  PageController pageC = new PageController();

  @override
  void initState() {
    super.initState();
    getChatMsgData();

    scrollController.addListener(() => FocusScope.of(context).requestFocus(new FocusNode()));
    initPlatformState();
    Notice.addListener(WeChatActions.msg(), (v) => getChatMsgData());
  }

  Future getChatMsgData() async {
    final str = await ChatDataRep().repData(widget.id, widget.type);
    List<ChatData> listChat = str;
    chatData.clear();
    chatData..addAll(listChat.reversed);
    if (mounted)
      setState(() {});
  }

  void insertText(String text) {
    var value = _textController.value;
    var start = value.selection.baseOffset;
    var end = value.selection.extentOffset;
    if (value.selection.isValid) {
      String newText = '';
      if (value.selection.isCollapsed) {
        if (end > 0) {
          newText += value.text.substring(0, end);
        }
        newText += text;
        if (value.text.length > end) {
          newText += value.text.substring(end, value.text.length);
        }
      } else {
        newText = value.text.replaceRange(start, end, text);
        end = start;
      }

      _textController.value = value.copyWith(
          text: newText,
          selection: value.selection.copyWith(
              baseOffset: end + text.length, extentOffset: end + text.length));
    } else {
      _textController.value = TextEditingValue(
          text: text,
          selection:
          TextSelection.fromPosition(TextPosition(offset: text.length)));
    }
  }

  void canCelListener() {
    if (_msgStreamSubs != null) _msgStreamSubs.cancel();
  }

  Future<void> initPlatformState() async {
    if (!mounted)
      return;

    if (_msgStreamSubs == null) {
      //_msgStreamSubs =
      //    im.onMessage.listen((dynamic onData) => getChatMsgData());
    }
  }

  _handleSubmittedData(String text) async {
    _textController.clear();
    chatData.insert(0, new ChatData(msg: {"text": text}));
    await sendTextMsg('${widget.id}', widget.type, text);
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
    if (keyboardHeight == 270.0 &&
        MediaQuery.of(context).viewInsets.bottom != 0) {
      keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    }
    var body = [
      chatData != null
          ? new ChatDetailsBody(scrollController: scrollController, chatData: chatData) // 创建聊天框界面
          : new Spacer(),
      new ChatDetailsRow( // 底部banner栏
        voiceOnTap: () => onTapHandle(ButtonType.voice),
        isVoice: _isVoice,
        edit: edit,
        more: new ChatMoreIcon( // 底部那个输入框栏
          value: _textController.text,
          onTap: () => _handleSubmittedData(_textController.text), // 发送消息
          moreTap: () => onTapHandle(ButtonType.more),
        ),
        id: widget.id,
        type: widget.type,
      ),
      new Container( // more弹出栏
        height: _isMore && !_focusNode.hasFocus ? keyboardHeight : 0.0,
        width: MediaQuery.of(context).size.width,
        color: Color(AppColors.ChatBoxBg),
        child: new IndicatorPageView(
          pageC: pageC,
          pages: List.generate(2, (index) {
            return new ChatMorePage(
              index: index,
              id: widget.id,
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
        onTap: () => routePush(new ChatInfoPage(widget.id)),
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
