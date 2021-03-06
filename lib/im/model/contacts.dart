import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../entity/i_contact_info_entity.dart';
import '../entity/person_info_entity.dart';
import '../friend_handle.dart';
import '../info_handle.dart';
import '../../tools/shared_util.dart';
import '../../config/keys.dart';
import '../../common/check.dart';
import '../../config/const.dart';
//import 'package:dim/pinyin/pinyin_helper.dart';

// 好友列表
class Contact {
  Contact({
    @required this.avatar,
    @required this.name,
    @required this.nameIndex,
    @required this.userId,
  });

  final String avatar;
  final String name;
  final String nameIndex; // 通讯录要按姓名字母排序
  final String userId;
}

class ContactsPageData {
  Future<bool> contactIsNull() async {
    final user = await SharedUtil.getInstance().getString(Keys.account);
    final result = await getContactsFriends(user);
    List<dynamic> data = json.decode(result);
    return !listNoEmpty(data);
  }

  listFriend() async {
    List<Contact> contacts = new List<Contact>();
    String avatar;
    String nickName;
    String userId;
    String remark;

    final contactsData = await SharedUtil.getInstance().getString(Keys.contacts);
    userId = await SharedUtil.getInstance().getString(Keys.userId);
    final result = await getContactsFriends(userId);

    getMethod(result) async {
      List<dynamic> dataMap = json.decode(result);
      int dLength = dataMap.length;
      for (int i = 0; i < dLength; i++) {
        if (Platform.isIOS) {
          IContactInfoEntity model = IContactInfoEntity.fromJson(dataMap[i]);
          avatar = model.profile.avatar;
          userId = model.userId;
          remark = await getRemarkMethod(model.userId, callback: (_) {});
          nickName = model.profile.nickname;
          nickName = !strNoEmpty(nickName) ? model.userId : nickName;
          contacts.insert(
            0,
            new Contact(
              avatar: !strNoEmpty(avatar) ? defIcon : avatar,
              name: !strNoEmpty(remark) ? nickName : remark,
              //nameIndex:
              //PinyinHelper.getFirstWordPinyin(nickName)[0].toUpperCase(),
              nameIndex: nickName,
              userId: userId,
            ),
          );
        } else {
          PersonInfoEntity model = PersonInfoEntity.fromJson(dataMap[i]);
          avatar = model.avatar;
          userId = model.userId;
          remark = await getRemarkMethod(model.userId, callback: (_) {});
          nickName = model.nickName;
          nickName = !strNoEmpty(nickName) ? model.userId : nickName;
          contacts.insert(
            0,
            new Contact(
              avatar: !strNoEmpty(avatar) ? defIcon : avatar,
              name: !strNoEmpty(remark) ? nickName : remark,
              //nameIndex:
              //PinyinHelper.getFirstWordPinyin(nickName)[0].toUpperCase(),
              nameIndex: nickName,
              userId: userId,
            ),
          );
        }
      }
      return contacts;
    }

    if (strNoEmpty(contactsData) || contactsData != '[]') {
      if (result != contactsData) {
        await SharedUtil.getInstance().saveString(Keys.contacts, result);
        return await getMethod(result);
      } else {
        return await getMethod(contactsData);
      }
    } else {
      await SharedUtil.getInstance().saveString(Keys.contacts, result);
      return await getMethod(result);
    }
  }
}
