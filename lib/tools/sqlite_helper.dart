import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:wechat/im/model/conversation_data.dart';
import '../config/storage_manager.dart';

class SqliteHelper {
  static final SqliteHelper _instance = new SqliteHelper.internal();
  static Database _db;

  factory SqliteHelper() => _instance;

  final String tableName = 'conversation_data';
  final String columnId = 'id';
  final String peerId = "peer_id";
  final String content = 'content';
  final String userId = 'user_id';
  final String createTime = 'create_time';

  SqliteHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    // 获取默认数据库位置(在Android上，它通常是data/data/<package_name>/databases,
    // 在iOS上，它是Documents目录)
    String databasesPath = await getDatabasesPath();
    // 相当于在上述方法获取到的位置创建了一个名为flashgo的数据库.
    String path = join(databasesPath, 'flashgo.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('''
        CREATE TABLE $tableName (
        $columnId INTEGER,
        $userId TEXT,
        $peerId TEXT,
        $content TEXT,
        $createTime INTEGER)
    ''');
  }

  Future<int> insert(ConversationData conversation) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableName, conversation.toJson());

    return result;
  }

  Future<List> selectSome({int limit, int offset}) async {
    var dbClient = await db;
    var result = await dbClient.query(
      tableName,
      columns: [columnId, userId, content, createTime],
      limit: limit,
      offset: offset,
    );
    List<ConversationData> results = [];
    result.forEach((item) => results.add(ConversationData.fromSql(item)));
    return results;
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

  Future<ConversationData> getOne(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableName,
        columns: [columnId, userId, peerId, content, createTime],
        where: '$id = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return ConversationData.fromSql(result.first);
    }

    return null;
  }

  Future<int> deleteNote(String contents) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableName, where: '$content = ?', whereArgs: [contents]);
  }

  Future<int> updateNote(ConversationData video) async {
    var dbClient = await db;
    return await dbClient.update(tableName, video.toJson(),
        where: "$columnId = ?", whereArgs: [video.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
