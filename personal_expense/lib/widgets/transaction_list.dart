import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTxn;

  TransactionList(this.transaction, this.deleteTxn);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      child: transaction.isEmpty ?
        LayoutBuilder(
          builder: (ctxt, constraint) =>
              Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraint.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
        )
          : ListView.builder(
          itemCount: transaction.length,
          itemBuilder: (ctxt, index) =>
              Dismissible(
                key: Key(transaction[index].id.toString()),
//                confirmDismiss: (dir)  {
//                  return  deleteTxn(index, transaction[index], context);
//                },
                onDismissed: (dir) => deleteTxn(index, transaction[index], context),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Theme.of(context).errorColor,
                  alignment: Alignment(1.0, 0.0),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  padding: EdgeInsets.all(20),
                  child: Icon(Icons.delete, color: Colors.white,),

                ),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${transaction[index].amount.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transaction[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(DateTime.parse(transaction[index].date))
                    ),
//                    trailing: MediaQuery.of(context).size.width > 460 ?
//                    FlatButton.icon(
//                        onPressed: () => deleteTxn(transaction[index].id),
//                        icon: Icon(Icons.delete),
//                        label: Text('Delete'),
//                        textColor: Theme.of(context).errorColor,) :
//                    IconButton(
//                      icon: Icon(Icons.delete),
//                      color: Theme.of(context).errorColor,
//                      onPressed: () => deleteTxn(transaction[index].id)
//
//                    ),
                  )
                ),
              )),
    );
  }



}

enum ConfirmAction {OK, CANCEL}
