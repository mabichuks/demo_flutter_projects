import 'dart:convert';

import 'package:flutter/material.dart';

class Transaction {
  int id;
  String title;
  double amount;
  String date;


  Transaction({
      this.id,
    @required this.title,
    @required this.amount,
    @required this.date
});

  factory Transaction.fromMap(Map<String, dynamic> json) {
    return new Transaction(
        id: json['id'],
        title: json['title'],
        amount: json['amount'],
        date: json['date']
    );
  }

  Map<String, dynamic> toMap() {
    return{
      'id': id,
      'title': title,
      'amount': amount,
      'date': date
    };
  }


  Transaction fromJson(String str) {
    final jsonData = json.decode(str);
    return Transaction.fromMap(jsonData);
  }

  String toJson(Transaction txn) {
    final data = txn.toMap();
    return json.encode(data);
  }
}