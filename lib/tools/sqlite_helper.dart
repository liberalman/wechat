import 'package:flutter/cupertino.dart';
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
/*
sudo find / -name flashgo.db

/Users/socho/Library/Developer/CoreSimulator/Devices/320F21BB-1439-4D62-B144-0BCBFFDD156E/data/Containers/Data/Application/38AC4C6B-6505-4F8B-B8B8-B8B4E4AB50C4/Documents/flashgo.db
*/
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    debugPrint(db.toString());
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
    await db.execute('''
    CREATE TABLE IF NOT EXISTS config (
        id TEXT,
        access_token TEXT,
        refresh_token TEXT,
        nick_name TEXT,
        avatar TEXT,
        expires_at INTEGER);
    ''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS user (
        id TEXT PRIMARY KEY,
        nick_name TEXT,
        avatar TEXT);
    ''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS conversation (
        room_id TEXT PRIMARY KEY,
        title TEXT,
        type TEXT,
        create_time INTEGER,
        update_time INTEGER);
    ''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS friend (
        id TEXT PRIMARY KEY,
        nick_name TEXT,
        avatar TEXT,
        expires_at INTEGER);
    ''');
    /*await db.transaction((txn) async {
      int id1 = await txn.rawInsert("INSERT INTO conversation(room_id,title,type,create_time,update_time) values('5c566802128c810b3772f9e5','Andy','C2C',datetime('now'),datetime('now'))");
      print('inserted1: $id1');
      int id2 = await txn.rawInsert("INSERT INTO conversation(room_id,title,type,create_time,update_time) values('5a5624e4ba18d80e4dd3162b','Liberalman','C2C',datetime('now'),datetime('now'))");
      print('inserted2: $id2');
    });*/
  }

  /*
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
