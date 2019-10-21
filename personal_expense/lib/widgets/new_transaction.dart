import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget{
  final Function addTx;
  final titleEditingController = TextEditingController();
  final amountEditingController = TextEditingController();
  NewTransaction(this.addTx);


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
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountEditingController,
            ),
            FlatButton(
              child: Text("Add Transaction"),
              textColor: Colors.purple,
              onPressed: () {
                addTx(titleEditingController.text,double.parse(amountEditingController.text) );
              },
            )
          ],
        ),
      ),
    );
  }

}