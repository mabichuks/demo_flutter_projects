import 'package:personal_expense/dao/TransactionDAO.dart';
import 'package:personal_expense/models/transaction.dart';

class TransactionRepository {
final dao = TransactionDAO();

Future<List<Transaction>> getAll() async {
  return await dao.getTransactions();
}

Future<int> add(Transaction txn) async {
  return await dao.addTransaction(txn);
}
}