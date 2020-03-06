import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteHelper {
  static final SqliteHelper _instance = new SqliteHelper.internal();
  static Database _db;

  factory SqliteHelper() => _instance;

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
    // 您不能精确地完成所要求的操作，但与某些RDBMS不同，SQLite能够在事务中执行DDL，并具有适当的结果。
    await db.execute('''
        CREATE TABLE IF NOT EXISTS chat (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        room_id TEXT,
        sender TEXT,
        content TEXT,
        create_time INTEGER);
        CREATE INDEX idx_room_id ON chat(room_id);
    ''');
  }

  /*Future<int> insert(ConversationData conversation) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableName, conversation.toJson());

    return result;
  }

  Future<List> selectSome({int limit, int offset}) async {
    var dbClient = await db;
    var result = await dbClient.query(
      tableName,
      columns: [columnId, sender, peer, content, createTime],
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
        columns: [columnId, sender, peer, content, createTime],
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
  }*/

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
