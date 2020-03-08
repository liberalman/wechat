import 'package:wechat/tools/sqlite_helper.dart';

class Friend {
  final String tableName = "friend";

  // sqlite不支持bool型
  String id; // 用户id
  String avatar; // 头像
  String nickName; // 昵称

  Friend({this.id, this.nickName, this.avatar});

  Friend.fromSql(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    nickName = json['nick_name'];
  }

  Friend.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    nickName = json['nick_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['nick_name'] = this.nickName;
    return data;
  }

  Future<int> insert(Friend data) async {
    var dbClient = await SqliteHelper().db;
    var result = await dbClient.insert(tableName, data.toJson());
    return result;
  }

  Future<Friend> find(String userId) async {
    var dbClient = await SqliteHelper().db;
    var result = await dbClient.query(
      tableName,
      columns: ["id", "avatar", "nick_name"],
      where: 'id = ?', whereArgs: [userId]
    );
    if (result.length > 0)
      return Friend.fromSql(result[0]);
    else
      return null;
  }

  Future<List> selectSome({int limit, int offset}) async {
    var dbClient = await SqliteHelper().db;
    var result = await dbClient.query(
      tableName,
      columns: ["id", "avatar", "nick_name"],
      limit: limit,
      offset: offset,
      orderBy: "nick_name",
    );
    List<Friend> results = [];
    result.forEach((item) => results.add(Friend.fromSql(item)));
    return results;
  }

  Future<int> delete(int id) async {
    var dbClient = await SqliteHelper().db;
    return await dbClient
        .delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
