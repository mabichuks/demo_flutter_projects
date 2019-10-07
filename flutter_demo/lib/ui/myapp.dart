import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String text = "Pizza";
    MaterialApp mApp = new MaterialApp(
      title: "Trip Cost Calculator",
      home: FuelForm(),
    );

    return mApp;
  }
}

class FuelForm extends StatefulWidget {
  @override
  createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  //Methods

  void _onDropDownChanged(String val) {
    setState(() {
      this._currency = val;
    });
  }

  final _currencies = ["Dollars", "Euro", "Pounds"];
  String _currency = "Dollars", result = "Hello";
  final double _formDistance = 5.0;
  // Controllers

  TextEditingController distanceController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController avgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.title;
    return new Scaffold(
      appBar: AppBar(
        title: Text("Trip Cost Calculator"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "eg 124",
                      labelText: "Distance",
                      labelStyle: style,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  controller: distanceController,
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setState(() {});
                  },
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "eg 17",
                      labelText: "Distance per unit",
                      labelStyle: style,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  controller: avgController,
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    setState(() {});
                  },
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: _formDistance, bottom: _formDistance),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child:TextField(
                        decoration: InputDecoration(
                            hintText: "eg 1.65",
                            labelText: "Price",
                            labelStyle: style,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          setState(() {});
                        },
                      ),
                    ),
                    Container(width: _formDistance * 5,),
                    Expanded(
                      child: DropdownButton<String>(
                          items: _currencies
                              .map((val) => DropdownMenuItem<String>(
                            value: val,
                            child: new Text(val),
                          ))
                              .toList(),
                          value: _currency,
                          onChanged: (value) => _onDropDownChanged(value)),
                    )

                  ],
                )
              ),

              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).buttonColor,
                      textColor: Theme.of(context).primaryColorDark,
                      onPressed: () {
                        setState(() {
                          reset();
                        });
                      },
                      child: (Text(
                        "Reset",
                        textScaleFactor: 1.5,
                      )),
                    ),
                  ),

                  Expanded(
                    child:RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      onPressed: () {
                        setState(() {
                          result = calculate();
                        });
                      },
                      child: (Text(
                        "Submit",
                        textScaleFactor: 1.5,
                      )),
                    ),
                  )
                ],
              ),
              Text(result)
            ],
          )),
    );
  }

  String calculate() {
    double _distance = double.parse(distanceController.text);
    double _fuelCost = double.parse(priceController.text);
    double _consumption = double.parse(avgController.text);
    String _totalCost =
        ((_distance / _consumption) * _fuelCost).toStringAsFixed(2);

    return "Total cost of trip is $_totalCost $_currency";
  }

  void reset() {
    distanceController.text = "";
    priceController.text = "";
    avgController.text = "";
    setState(() {
      result = "";
    });
  }
}
