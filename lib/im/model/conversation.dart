import 'package:wechat/tools/sqlite_helper.dart';

class Conversation {
  final String tableName = "conversation";

  // sqlite不支持bool型
  String roomId; // 房间号，一对一聊天的话，就是对方的用户id了，群组聊天是生成的聊天id
  String title; // 房间名称，一对一聊就是对方备注名了
  String type; // C2C一对一聊天，C2B群聊
  int createTime;
  int updateTime;

  Conversation({this.roomId, this.title, this.type, this.createTime, this.updateTime});

  Conversation.fromSql(Map<String, dynamic> json) {
    roomId = json['room_id'];
    title = json['title'];
    type = json['type'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
  }

  Conversation.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    title = json['title'];
    type = json['type'];
    createTime = int.parse(json['create_time']);
    updateTime = int.parse(json['update_time']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    return data;
  }

  Future<int> insert(Conversation conversation) async {
    var dbClient = await SqliteHelper().db;
    var result = await dbClient.insert(tableName, conversation.toJson());
    return result;
  }

  Future<Conversation> find(String roomeId) async {
    var dbClient = await SqliteHelper().db;
    var result = await dbClient.query(
      tableName,
      columns: ["room_id", "type", "title", "create_time", "update_time"],
      where: 'room_id = ?', whereArgs: [roomeId]
    );
    if (result.length > 0)
      return Conversation.fromSql(result[0]);
    else
      return null;
  }

  Future<List> findSome({int limit, int offset}) async {
    var dbClient = await SqliteHelper().db;
    var result = await dbClient.query(
      tableName,
      columns: ["room_id", "type", "title", "create_time", "update_time"],
      limit: limit,
      offset: offset,
      orderBy: "-update_time",
    );
    List<Conversation> results = [];
    result.forEach((item) => results.add(Conversation.fromSql(item)));
    return results;
  }

  Future<int> delete(int id) async {
    var dbClient = await SqliteHelper().db;
    return await dbClient
        .delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
