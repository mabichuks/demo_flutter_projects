import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:personal_expense/models/transaction.dart' as model;

class DbProvider {

  DbProvider._();
  static final DbProvider instance = DbProvider._();

  final tableName = "Transactions";

  static Database _database;

  factory DbProvider() {
    return instance;
  }

  Future<Database> get db async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'Personal_expense_db');
    return await openDatabase(
        path,
        version: 1,
        onOpen: (_){},
        onCreate: (db, version) async {
      await db.execute('CREATE TABLE $tableName ('
          'id INTEGER PRIMARY KEY,'
          'title TEXT,'
          'amount REAL,'
          'date TEXT'
          ')');
    });
  }



}