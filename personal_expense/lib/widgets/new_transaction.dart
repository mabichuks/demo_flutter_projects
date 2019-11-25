import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget{
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleEditingController = TextEditingController();

  final _amountEditingController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    String title = _titleEditingController.text;
    double amount = double.parse(_amountEditingController.text);

    if(title.isEmpty || amount <= 0 || _selectedDate == null) return;

    widget.addTx(title,amount, _selectedDate );

    Navigator.of(context).pop();

  }
  
  void _presentDatePicker() async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now());
    if(date == null ) return;
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery =    MediaQuery.of(context);


    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: mediaQuery.viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: _titleEditingController,
                onSubmitted: (_) => _submitData(),

              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: _amountEditingController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text(_selectedDate == null ? 'No date chosen' : 'Picked date: ${DateFormat.yMd().format(_selectedDate)}')),
                    FlatButton(
                      child: Text('Choose date', style: TextStyle(fontWeight: FontWeight.bold),),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              ),
              RaisedButton(
                child: Text("Add Transaction"),
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColor,
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}