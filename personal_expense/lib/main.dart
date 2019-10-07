import 'package:flutter/material.dart';
import 'package:personal_expense/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final List<Transaction> transactions = [
      Transaction(
        id: "1", title: "Groceries", amount: 122.40,date: DateTime.now()
      ),
      Transaction(
          id: "2", title: "Clothes", amount: 300.50,date: DateTime.now()
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text("CHART"),
              elevation: 5,
            ),
          ),
          Column(
            children: transactions.map((tx) =>
            Card(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Text(
                        tx.amount.toStringAsFixed(2),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.purple
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                        width: 2
                      ),
                    ),
                    
                    padding: EdgeInsets.all(10),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          tx.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                        ),
                      ),
                      Text(
                          tx.date.toIso8601String(),
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
            ).toList(),
          )
        ],
      )
    );
  }
}
