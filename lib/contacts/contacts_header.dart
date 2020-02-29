import 'package:flutter/material.dart';
import './contacts_item.dart';

class ContactHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        ContactItem(titleName: '新的朋友', imageName: 'images/add_friend_icon_addgroup@2x.png'),
        ContactItem(titleName: '群聊', imageName: 'images/add_friend_icon_addgroup@2x.png'),
        ContactItem(titleName: '公众号', imageName: 'images/add_friend_icon_offical@2x.png'),
      ],
    );
  }
}