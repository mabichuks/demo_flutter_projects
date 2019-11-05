import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget{
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleEditingController = TextEditingController();

  final amountEditingController = TextEditingController();

  void submitData() {
    String title = titleEditingController.text;
    double amount = double.parse(amountEditingController.text);

    if(title.isEmpty || amount <= 0) return;

    widget.addTx(title,amount );

    Navigator.of(context).pop();

  }

  @override
  Widget build(BuildContext context) {


    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleEditingController,
              onSubmitted: (_) => submitData(),

            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountEditingController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              child: Text("Add Transaction"),
              textColor: Theme.of(context).primaryColor,
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}