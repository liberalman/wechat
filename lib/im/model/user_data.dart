import 'dart:io';
import '../../config/const.dart';
import '../../config/keys.dart';
import '../../common/check.dart';
import '../../tools/shared_util.dart';
import '../entity/i_contact_info_entity.dart';
import '../entity/i_person_info_entity.dart';
import '../entity/person_info_entity.dart';
import 'package:flutter/material.dart';
import '../friend_handle.dart';
import '../info_handle.dart';
import 'dart:convert';

class UserData {
  UserData({
    @required this.avatar,
    @required this.nickName,
    @required this.userId,
    @required this.isAdd,
  });

  final String avatar;
  final String nickName;
  final String userId;
  final bool isAdd;
}

class UserDataPageGet {
  List ids = [
    '1',
    '2',
    '3',
  ];

  listUserData() async {
    List<UserData> userData = new List<UserData>();
    for (int i = 0; i < ids.length; i++) {
      final profile = await getUsersProfile([ids[i]]);
      List<dynamic> profileData = json.decode(profile);
      for (int i = 0; i < profileData.length; i++) {
        String avatar;
        String nickName;
        String userId;
        if (Platform.isIOS) {
          IPersonInfoEntity info = IPersonInfoEntity.fromJson(profileData[i]);
          userId = info.userId;
          if (strNoEmpty(info?.avatar) && info?.avatar != '[]') {
            avatar = info?.avatar ?? defIcon;
          } else {
            avatar = defIcon;
          }
          nickName =
              strNoEmpty(info?.nickname) ? info?.nickname : userId ?? '未知';
        } else {
          PersonInfoEntity info = PersonInfoEntity.fromJson(profileData[i]);
          userId = info.userId;
          if (strNoEmpty(info?.avatar) && info?.avatar != '[]') {
            avatar = info?.avatar ?? defIcon;
          } else {
            avatar = defIcon;
          }
          nickName =
              strNoEmpty(info?.nickName) ? info?.nickName : userId ?? '未知';
        }

        final result = await getContactsFriends(userId);
        userData.insert(
          0,
          new UserData(
            avatar: avatar,
            nickName: nickName,
            userId: userId,
            isAdd: result.toString().contains(userId),
          ),
        );
      }
    }
    return userData;
  }
}
