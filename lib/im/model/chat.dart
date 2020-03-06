import 'package:wechat/tools/sqlite_helper.dart';

class Chat {
  final String tableName = "chat";

  // sqlite不支持bool型
  int id; // message id
  String roomId; // 房间号
  String sender; // 发信息的用户id
  int createTime; // 创建时间
  String content; // 内容

  Chat({this.id, this.sender, this.roomId, this.content, this.createTime});

  Chat.fromSql(Map<String, dynamic> json) {
    id = json['id'];
    roomId = json['room_id'];
    content = json['content'];
    sender = json['sender'];
    createTime = json['create_time'];
  }

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomId = json['room_id'];
    content = json['content'];
    sender = json['sender'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['room_id'] = this.roomId;
    data['content'] = this.content;
    data['sender'] = this.sender;
    data['create_time'] = this.createTime;
    return data;
  }

  Future<int> insert(Chat chat) async {
    var dbClient = await SqliteHelper().db;
    var result = await dbClient.insert(tableName, chat.toJson());

    return result;
  }

  Future<List> selectSome({String roomId, int limit, int offset}) async {
    var dbClient = await SqliteHelper().db;
    var result = await dbClient.query(
      tableName,
      columns: ["id", "room_id", "sender", "content", "create_time"],
      limit: limit,
      offset: offset,
      where: 'room_id = ?', whereArgs: [roomId],
      orderBy: "-create_time",
    );
    List<Chat> results = [];
    result.forEach((item) => results.add(Chat.fromSql(item)));
    return results;
  }

  Future<int> delete(int id) async {
    var dbClient = await SqliteHelper().db;
    return await dbClient
        .delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
