import 'package:wechat/tools/sqlite_helper.dart';

class ConversationData {
  final String tableName = "conversation_data";

  // sqlite不支持bool型
  int id; // 会话id
  String sender; // 用户id
  String peer; // 对方userid
  int createTime; // 创建时间
  String content; // 内容

  ConversationData({this.id, this.sender, this.peer, this.content, this.createTime});

  ConversationData.fromSql(Map<String, dynamic> json) {
    id = json['id'];
    peer = json['peer'];
    content = json['content'];
    sender = json['sender'];
    createTime = json['create_time'];
  }

  ConversationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    peer = json['peer'];
    content = json['content'];
    sender = json['sender'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['peer'] = this.peer;
    data['content'] = this.content;
    data['sender'] = this.sender;
    data['create_time'] = this.createTime;
    return data;
  }

  Future<int> insert(ConversationData conversation) async {
    var dbClient = await SqliteHelper().db;
    var result = await dbClient.insert(tableName, conversation.toJson());

    return result;
  }

  Future<List> selectSome({String id, int limit, int offset}) async {
    var dbClient = await SqliteHelper().db;
    var result = await dbClient.query(
      tableName,
      columns: ["id", "sender", "peer", "content", "create_time"],
      limit: limit,
      offset: offset,
      where: 'sender = ? or peer = ?', whereArgs: [id, id],
      orderBy: "-create_time",
    );
    List<ConversationData> results = [];
    result.forEach((item) => results.add(ConversationData.fromSql(item)));
    return results;
  }

  Future<int> delete(int id) async {
    var dbClient = await SqliteHelper().db;
    return await dbClient
        .delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
