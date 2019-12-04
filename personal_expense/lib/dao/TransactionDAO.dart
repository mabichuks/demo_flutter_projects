import 'package:personal_expense/data/DbProvider.dart';
import 'package:personal_expense/models/transaction.dart' as model;
import 'package:sqflite/sqflite.dart';

class TransactionDAO {

  final _provider = DbProvider();
  final _tableName = "Transactions";

  Future<int> addTransaction(model.Transaction txn) async{
    final database = await _provider.db;
    int res =await database.insert('$_tableName', txn.toMap());
    return res;
  }

  Future<List<model.Transaction>> getTransactions() async {
    final database = await _provider.db;
    List<Map<String, dynamic>> res = await database.query('$_tableName');
    List<model.Transaction> data = res.isNotEmpty ? res.map((json) => model.Transaction.fromMap(json)).toList() : [];
    return data;
  }

  Future<model.Transaction> getById(int id) async {
    final database = await _provider.db;
    List<Map<String, dynamic>> res = await database.query('$_tableName', where: 'id = ?', whereArgs: [id]);
    model.Transaction transaction = res.isNotEmpty ? model.Transaction.fromMap(res.first): null;
    return transaction;
  }


  Future<int> updateTransaction(model.Transaction txn) async {
    final database = await _provider.db;
    int res = await database.update('$_tableName', txn.toMap(), whereArgs: [txn.toMap()]);
    return res;
  }

  Future<int> deleteTransaction(int id) async {
    final database = await _provider.db;
    int res = await database.delete('$_tableName', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> getCount() async {
    final database = await _provider.db;
    int res = Sqflite.firstIntValue(await database.rawQuery('Select count (*) from $_tableName'));
    return res;
  }
}