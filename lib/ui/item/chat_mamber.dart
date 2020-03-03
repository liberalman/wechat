import '../../im/entity/person_info_entity.dart';
import '../../pages/contacts/contacts_details_page.dart';
import 'package:flutter/material.dart';

import '../../tools/wechat_flutter.dart';

class ChatMamBer extends StatefulWidget {
  final dynamic model;

  ChatMamBer({this.model});

  @override
  _ChatMamBerState createState() => _ChatMamBerState();
}

class _ChatMamBerState extends State<ChatMamBer> {
  @override
  Widget build(BuildContext context) {
    String face =
        Platform.isIOS ? widget.model?.faceURL : widget.model?.faceUrl;
    String name =
        Platform.isIOS ? widget.model?.nickname : widget.model?.nickName;

    List<Widget> wrap = [];

    wrap.add(
      new Wrap(
        spacing: (MediaQuery.of(context).size.width - 315) / 5,
        runSpacing: 10.0,
        children: [0].map((item) {
          return new InkWell(
            child: new Container(
              width: 55.0,
              child: new Column(
                children: <Widget>[
                  new ImageView(
                    img: strNoEmpty(face) ? face : defAvatar,
                    width: 55.0,
                    height: 55.0,
                    fit: BoxFit.cover,
                  ),
                  new Space(height: mainSpace / 2),
                  new Text(
                    strNoEmpty(name) ? name : '无名氏',
                    style: TextStyle(color: mainTextColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            onTap: () => routePush(new ContactsDetailsPage(
                id: widget.model.identifier, title: name, avatar: face)),
          );
        }).toList(),
      ),
    );

    wrap.add(
      new InkWell(
        child: new Container(
          decoration:
              BoxDecoration(border: Border.all(color: lineColor, width: 0.2)),
          child: new Image.asset('assets/images/chat/ic_details_add.png',
              width: 55.0, height: 55.0, fit: BoxFit.cover),
        ),
        onTap: () {},
      ),
    );

    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: new Wrap(
        spacing: (MediaQuery.of(context).size.width - 315) / 5,
        runSpacing: 10.0,
        children: wrap,
      ),
    );
  }
}
