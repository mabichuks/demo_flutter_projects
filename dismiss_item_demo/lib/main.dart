import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final items = List<String>.generate(20, (i) => "item ${1 + i}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return Dismissible(
                key: Key(item),
                confirmDismiss: (dir) async {
                  final ConfirmAction action =
                      await _asyncConfirmDialog(context);
                  if (action == ConfirmAction.Accept) {
                    setState(() {
                      items.removeAt(index);
                    });
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("$item dismissed"),
                    ));
                    return true;
                  }
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("$item not dismissed"),
                  ));
                  return false;
                },
                background: Container(
                  color: Colors.red,
                ),
                child: ListTile(title: Text("${items[index]}")),
              );
            }));
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
        context: context,
        barrierDismissible: false,
        builder: (ctxt) => AlertDialog(
              title: Text("Delete item?"),
              content: const Text("This action is not reversible"),
              actions: <Widget>[
                FlatButton(
                  child: const Text('CANCEL'),
                  onPressed: () =>
                    Navigator.of(ctxt).pop(ConfirmAction.Cancel)

                ),
                FlatButton(
                  child: const Text('OK'),
                  onPressed: () =>
                    Navigator.of(ctxt).pop(ConfirmAction.Accept)
                )
              ],
            ));
  }
}

enum ConfirmAction { Cancel, Accept }
