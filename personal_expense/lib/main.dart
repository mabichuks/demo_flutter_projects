import 'package:flutter/material.dart';
import 'package:personal_expense/widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'models/transaction.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          )
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [
//    Transaction(
//        id: "1", title: "Groceries", amount: 122.40,date: DateTime.now()
//    ),
//    Transaction(
//        id: "2", title: "Clothes", amount: 300.50,date: DateTime.now()
//    )
  ];
  bool _showChart = false;

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(title: title, amount: amount, date: date, id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  Future<ConfirmAction> _confirmDeleteItem(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false,
      builder: (ctxt) => AlertDialog(
        title: Text('Detele Item?', style: TextStyle(color: Theme.of(context).textTheme.title.color),),
        content: Text('This action cannot be reversed',),
        actions: <Widget>[
          FlatButton(
            child: Text('CANCEL',),
            onPressed: () => Navigator.of(context).pop(ConfirmAction.CANCEL),
          ),
          FlatButton(
            child: Text('OK', style: TextStyle(color: Theme.of(context).errorColor),),
            onPressed: () => Navigator.of(context).pop(ConfirmAction.OK),
          )
        ],
      ),
    );
  }

  Future<bool> _removeTransaction(String id, BuildContext context) async {
    //setState(() => _userTransactions.removeWhere((txn) => txn.id == id));
    final ConfirmAction action =
        await _confirmDeleteItem(context);
    if (action == ConfirmAction.OK) {
      setState(() {
        _userTransactions.removeWhere((txn) => txn.id == id);
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Transaction dismissed"),
      ));
      return true;
    }
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Transaction not dismissed"),
    ));
    return false;
  }



  List<Transaction> get _recentTxn {
    return _userTransactions.where((x) => x.date.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
  }

  void _openTransactionModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => GestureDetector(
          onTap: () {},
            child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery =  MediaQuery.of(context);

    final appBar = AppBar(
      title: Text('Personal Expense'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransactionModal(context),
        ),
      ],
    );

    final _isLandscape = mediaQuery.orientation == Orientation.landscape;
    final _txnList = Container(
        height: (
            mediaQuery.size.height
                - appBar.preferredSize.height
                - mediaQuery.padding.top)
            * 0.7,
        child: TransactionList(_userTransactions, _removeTransaction));
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (_isLandscape) Row( // ignore: sdk_version_ui_as_code
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _showChart ? 'Show list': 'Show chart',
                    style: TextStyle(color: Theme.of(context).primaryColorDark),
                  ),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    }
                  )
                ],
              ),
              if(!_isLandscape) Container(
                  height: (
                      mediaQuery.size.height
                          - appBar.preferredSize.height
                          - mediaQuery.padding.top)
                      * 0.3,
                  child: Chart(_recentTxn)),
                 if(!_isLandscape) _txnList,
              if(_isLandscape)_showChart ?
              Container(
                  height: (
                      mediaQuery.size.height
                          - appBar.preferredSize.height
                          - mediaQuery.padding.top)
                      * 0.7,
                  child: Chart(_recentTxn))
              :_txnList,
            ],
          ),
        ) ,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionModal(context),
    ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
