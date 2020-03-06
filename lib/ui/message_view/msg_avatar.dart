import 'package:flutter/material.dart';
import '../../im/model/chat_data.dart';
import '../../pages/contacts/contacts_details_page.dart';
import '../../provider/global_model.dart';
import '../../tools/wechat_flutter.dart';

class MsgAvatar extends StatelessWidget {
  final GlobalModel globalModel;
  final ChatData model;

  MsgAvatar({@required this.globalModel, @required this.model});

  @override
  Widget build(BuildContext context) {
    String img;
    /*if (model.userId == globalModel.userId) { // 是自己
      if (null == model.avatar || '' == model.avatar)
        img = defIcon;
      else
        img = model.avatar;
    }*/
      img = model.avatar;
    return new InkWell(
      child: new Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        margin: EdgeInsets.only(right: 10.0),
        child: new ImageView(
          /*img: model.id == globalModel.account // 如果是自己，就把自己的头像显示上去；否则显示别人的头像
              ? globalModel.avatar??defIcon
              : model.avatar,*/
          img: img,
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ),
      ),
      onTap: () {
        routePush(new ContactsDetailsPage(
          title: model.nickName,
          avatar: model.avatar,
          id: model.userId,
        ));
      },
    );
  }
}
