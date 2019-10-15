import 'package:flutter/material.dart';
import 'package:personal_expense/models/transaction.dart';
import 'package:intl/intl.dart';

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
        mainAxisAlignment: MainAxisAlignment.start,
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
          Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment:CrossAxisAlignment.end,
                  children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: "Title"),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Amount"),
                  ),
                  FlatButton(
                    child: Text("Add Transaction"),
                    textColor: Colors.purple,
                    onPressed: () {},
                  )
                ],
              ),
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
                        '\$${tx.amount.toStringAsFixed(2)}',
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
                         DateFormat.yMMMd().format(tx.date),
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
