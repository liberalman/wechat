import 'package:wechat/tools/sqlite_helper.dart';

class User {
  final String tableName = "user";

  // sqlite不支持bool型
  String id; // 用户id
  String avatar; // 头像
  String nickName; // 昵称

  User({this.id, this.nickName, this.avatar});

  User.fromSql(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    nickName = json['nick_name'];
  }

  User.fromJson(Map<String, dynamic> json) {
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

  Future<int> insert(User data) async {
    var dbClient = await SqliteHelper().db;
    var result = await dbClient.insert(tableName, data.toJson());
    return result;
  }

  Future<User> find(String userId) async {
    var dbClient = await SqliteHelper().db;
    var result = await dbClient.query(
      tableName,
      columns: ["id", "avatar", "nick_name"],
      where: 'id = ?', whereArgs: [userId]
    );
    if (result.length > 0)
      return User.fromSql(result[0]);
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
      orderBy: "-create_time",
    );
    List<User> results = [];
    result.forEach((item) => results.add(User.fromSql(item)));
    return results;
  }

  Future<int> delete(int id) async {
    var dbClient = await SqliteHelper().db;
    return await dbClient
        .delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
