import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:personal_expense/models/transaction.dart' as model;

class DbProvider {

  DbProvider._();
  static final DbProvider provider = DbProvider._();

  final tableName = "Transactions";

  static Database _database;

  factory DbProvider() {
    return provider;
  }

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'Personal_expense_db');
    return await openDatabase(path, version: 1, onOpen: (_){}, onCreate: (db, version) async {
      await db.execute('CREATE TABLE $tableName ('
          'id INTEGER PRIMARY KEY,'
          'title TEXT,'
          'amount REAL,'
          'date TEXT'
          ')');
    });
  }

  Future<int> addTransaction(model.Transaction txn) async{
    final db = await database;
    int res =await db.insert('$tableName', txn.toMap());
    return res;
  }

  Future<List<model.Transaction>> getTransactions() async {
    final db = await database;
    List<Map<String, dynamic>> res = await db.query('$tableName');
    List<model.Transaction> data = res.isNotEmpty ? res.map((json) => model.Transaction.fromMap(json)).toList() : [];
    return data;
  }
  
  Future<model.Transaction> getById(int id) async {
    final db = await database;
    List<Map<String, dynamic>> res = await db.query('$tableName', where: 'id = ?', whereArgs: [id]);
    model.Transaction transaction = res.isNotEmpty ? model.Transaction.fromMap(res.first): null;
    return transaction;
  }


  Future<int> updateTransaction(model.Transaction txn) async {
    final db = await database;
    int res = await db.update('$tableName', txn.toMap(), whereArgs: [txn.toMap()]);
    return res;
  }
  
  Future<int> deleteTransaction(int id) async {
    final db = await database;
    int res = await db.delete('$tableName', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> getCount() async {
    final db = await database;
    int res = Sqflite.firstIntValue(await db.rawQuery('Select count (*) from $tableName'));
    return res;
  }

}