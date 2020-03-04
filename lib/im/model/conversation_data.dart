import 'package:wechat/tools/sqlite_helper.dart';

class ConversationData {
  final String tableName = "conversation_data";

  // sqlite不支持bool型
  int id; // 会话id
  String userId; // 用户id
  String peerId; // 对方userid
  int createTime; // 创建时间
  String content; // 内容

  ConversationData({this.id, this.userId, this.peerId, this.content, this.createTime});

  ConversationData.fromSql(Map<String, dynamic> json) {
    id = json['id'];
    peerId = json['peer_id'];
    content = json['content'];
    userId = json['user_id'];
    createTime = json['create_time'];
  }

  ConversationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    peerId = json['peer_id'];
    content = json['content'];
    userId = json['user_id'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['peer_id'] = this.peerId;
    data['content'] = this.content;
    data['user_id'] = this.userId;
    data['create_time'] = this.createTime;
    return data;
  }

  Future<int> insert(ConversationData conversation) async {
    var dbClient = await SqliteHelper().db;
    var result = await dbClient.insert(tableName, conversation.toJson());

    return result;
  }

  Future<List> selectSome({int limit, int offset}) async {
    var dbClient = await SqliteHelper().db;
    var result = await dbClient.query(
      tableName,
      columns: ["id", "user_id", "peer_id", "content", "create_time"],
      limit: limit,
      offset: offset,
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
