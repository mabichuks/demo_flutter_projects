import 'package:flutter/material.dart';
import 'package:personal_expense/data/DbProvider.dart';
import 'package:personal_expense/widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'bloc/TransactionBloc.dart';
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

   List<Transaction> _userTransactions;
   final bloc = TransactionBloc();

  bool _showChart = false;

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(title: title, amount: amount, date: date.toString());
    bloc.addTransaction(newTx);

//    setState(() {
//      _userTransactions.add(newTx);
//    });
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

   void _deleteTransaction(int index, Transaction deletedTxn, BuildContext context) {
     setState(() {
       _userTransactions.removeAt(index);
     });
     Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Transaction deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _userTransactions.insert(index, deletedTxn);
          });
        },
      ),
    )).closed.then((reason) {
      if(reason != SnackBarClosedReason.action) {
        bloc.deleteTransaction(deletedTxn.id);
      }
     });
   }


//  Future<bool> _removeTransaction(String id, BuildContext context) async {
//    //setState(() => _userTransactions.removeWhere((txn) => txn.id == id));
//    final ConfirmAction action =
//        await _confirmDeleteItem(context);
//    if (action == ConfirmAction.OK) {
//      setState(() {
//        _userTransactions.removeWhere((txn) => txn.id.toString() == id);
//      });
//      Scaffold.of(context).showSnackBar(SnackBar(
//        content: Text("Transaction dismissed"),
//      ));
//      return true;
//    }
//    Scaffold.of(context).showSnackBar(SnackBar(
//      content: Text("Transaction not dismissed"),
//    ));
//    return false;
//  }


  List<Transaction> _getRecentTxn(List<Transaction> txn) {
    if(txn != null)
      return txn.where((x) => DateTime.parse(x.date).isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
    return [];
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
        child: StreamBuilder<List<Transaction>>(
          stream: bloc.transactions,
          builder: (ctxt, snapshot) {
              if(snapshot.hasData) {
                _userTransactions = snapshot.data;
                print('User trans $_userTransactions');
                print('=============');
                print('Snapshot $snapshot.data');
                  return TransactionList(_userTransactions, _deleteTransaction);
              } //else return TransactionList(_userTransactions, _deleteTransaction);
            return Center(child: CircularProgressIndicator(),);
          }
        ));//TransactionList(_userTransactions, _removeTransaction));
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
                  child: StreamBuilder<List<Transaction>>(
                    stream: bloc.transactions,
                    builder: (context, snapshot) {
                      List<Transaction> _recentTxn = _getRecentTxn(snapshot.data);
                      return Chart(_recentTxn);
                    }
                  )),
                 if(!_isLandscape) _txnList,
              if(_isLandscape)_showChart ?
              Container(
                  height: (
                      mediaQuery.size.height
                          - appBar.preferredSize.height
                          - mediaQuery.padding.top)
                      * 0.7,
                  child: StreamBuilder<List<Transaction>>(
                      stream: bloc.transactions,
                      builder: (context, snapshot) {
                        List<Transaction> _recentTxn = _getRecentTxn(snapshot.data);
                        return Chart(_recentTxn);
                    }
                  ))
              :_txnList,
            ],
          ),
        ) ,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionModal(context),
    ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
