import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_application_1/models/team.dart';

class DatabaseHelper {
  static final _databaseName = 'flutter_application_1.db';
  static final _databaseVersion = 1;

  static final table = 'teams';
  static final columnId = 'id';
  static final columnName = 'name';
  static final columnFoundationYear = 'foundationYear';
  static final columnLastChampionship = 'lastChampionship';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnFoundationYear INTEGER NOT NULL,
        $columnLastChampionship TEXT
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute('''
        ALTER TABLE $table ADD COLUMN $columnLastChampionship TEXT
      ''');
    }
  }

  Future<List<Team>> getTeams() async {
    final db = await instance.database;
    final result = await db.query(table);
    return result.map((json) => Team.fromMap(json)).toList();
  }

  Future<int> insertTeam(Team team) async {
    final db = await instance.database;
    return await db.insert(table, team.toMap());
  }

  Future<void> deleteTeam(int id) async {
    final db = await instance.database;
    await db.delete(table, where: '$columnId =?', whereArgs: [id]);
  }

  Future<void> updateTeam(Team team) async {
    final db = await instance.database;
    await db.update(table, team.toMap(), where: '$columnId =?', whereArgs: [team.id]);
  }
}
