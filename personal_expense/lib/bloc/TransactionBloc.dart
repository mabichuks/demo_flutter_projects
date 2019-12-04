
import 'dart:async';

import 'package:personal_expense/models/transaction.dart';
import 'package:personal_expense/repository/TransactionRepository.dart';

class TransactionBloc {
  final _txnRepo = TransactionRepository();

  final _transactionController = StreamController<List<Transaction>>.broadcast();
  //final bloc = TransactionBloc();

   Stream<List<Transaction>> get transactions => _transactionController.stream;

   TransactionBloc() {
     getTransactions();
   }

   void getTransactions() async {
    return _transactionController.sink.add(await _txnRepo.getAll());
   }

   void addTransaction(Transaction txn) async {
     await _txnRepo.add(txn);
     getTransactions();
   }

   void dispose() {
     _transactionController.close();
   }
}