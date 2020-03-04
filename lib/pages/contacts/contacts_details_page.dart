import '../chat/chat_page.dart';
import '../chat/more_info_page.dart';
import '../chat/set_remark_page.dart';
import '../wechat_friends/page/wechat_friends_circle.dart';
import '../../provider/global_model.dart';
import '../../ui/dialog/friend_item_dialog.dart';
import '../../ui/item/contact_card.dart';
import '../../ui/other/button_row.dart';
import '../../ui/other/label_row.dart';
import '../../ui/ui.dart';
import '../../ui/bar/common_bar.dart';
import '../../config/const.dart';
import 'package:flutter/material.dart';
import '../../common/route.dart';
import '../../tools/wechat_flutter.dart';
import 'package:provider/provider.dart';
import '../../ui/dialog/show_toast.dart';

class ContactsDetailsPage extends StatefulWidget {
  final String avatar, title, id;

  ContactsDetailsPage({this.avatar, this.title, this.id});

  @override
  _ContactsDetailsPageState createState() => _ContactsDetailsPageState();
}

class _ContactsDetailsPageState extends State<ContactsDetailsPage> {
  List<Widget> body(bool isSelf) {
    return [
      new ContactCard(
        img: widget.avatar,
        id: widget.id,
        title: widget.title,
        nickName: widget.title,
        area: '北京 海淀',
        isBorder: true,
      ),
      new Visibility(
        visible: !isSelf,
        child: new LabelRow(
          label: '设置备注和标签',
          onPressed: () => routePush(new SetRemarkPage()),
        ),
      ),
      new Space(),
      new LabelRow(
        label: '朋友圈',
        isLine: true,
        lineWidth: 0.3,
        onPressed: () => routePush(new WeChatFriendsCircle()),
      ),
      new LabelRow(
        label: '更多信息',
        onPressed: () => routePush(new MoreInfoPage()),
      ),
      new ButtonRow(
        margin: EdgeInsets.only(top: 10.0),
        text: '发消息',
        isBorder: true,
        onPressed: () => routePushReplace(
            new ChatPage(id: widget.id, title: widget.title, type: 1)), // 跳转到聊天页面
      ),
      new Visibility(
        visible: !isSelf,
        child: new ButtonRow(
          text: '音视频通话',
          onPressed: () => showToast(context, '敬请期待'),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);
    bool isSelf = globalModel.account == widget.id;

    var rWidget = [
      new SizedBox(
        width: 60,
        child: new FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () =>
              friendItemDialog(context, userId: widget.id, suCc: (v) {
                if (v) Navigator.of(context).maybePop();
              }),
          child: new Image.asset(contactAssets + 'ic_contacts_details.png'),
        ),
      )
    ];

    return new Scaffold(
      backgroundColor: chatBg,
      appBar: new ComMomBar(
          title: '',
          backgroundColor: Colors.white,
          rightDMActions: isSelf ? [] : rWidget),
      body: new SingleChildScrollView(
        child: new Column(children: body(isSelf)),
      ),
    );
  }
}
