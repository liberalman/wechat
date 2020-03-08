import 'package:flutter/cupertino.dart';
import 'package:wechat/tools/sqlite_helper.dart';

class Config {
  final String tableName = "config";

  // sqlite不支持bool型
  String id; // 用户id
  String avatar; // 头像
  String nickName; // 昵称
  String accessToken;
  String refreshToken;
  int expiresAt; // 过期时间

  Config({@required this.id, this.nickName, this.avatar, @required this.accessToken, this.refreshToken, this.expiresAt});

  Config.fromSql(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    nickName = json['nick_name'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    expiresAt = json['expires_at'];
  }

  Config.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    nickName = json['nick_name'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['nick_name'] = this.nickName;
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['expires_at'] = this.expiresAt;
    return data;
  }

  Future<int> insert(Config config) async {
    var dbClient = await SqliteHelper().db;debugPrint(config.toJson().toString());
    var result = await dbClient.insert(tableName, config.toJson());
    return result;
  }

  Future<Config> get() async {
    var dbClient = await SqliteHelper().db;
    var result = await dbClient.query(tableName,
        columns: [
          "id",
          "avatar",
          "nick_name",
          "avatar",
          "refresh_token",
          "expires_at"
        ],
        limit: 1);
    return Config.fromSql(result[0]);
  }

  Future<int> delete(int id) async {
    var dbClient = await SqliteHelper().db;
    return await dbClient.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
