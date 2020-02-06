import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {

   final Function setFilter;
   final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.setFilter);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {

    _glutenFree = widget.currentFilters['gluten'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Filters'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'vegetarian' : _vegetarian,
                  'vegan' : _vegan,
                  'lactose' : _lactoseFree,
                };

                widget.setFilter(selectedFilters);

                final snackBar = SnackBar(
                  content: Text('Filter saved'),
                  duration: Duration(seconds: 2),
                );
                _scaffoldKey.currentState.showSnackBar(snackBar);

              },
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              child: Text(
                'Adjust your meal selection',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildSwitchListTile('Gluten-free',
                      'Only include gluten-free meals', _glutenFree, (val) {
                    setState(() {
                      _glutenFree = val;
                    });
                  }),
                  _buildSwitchListTile('Vegetarian',
                      'Only include vegetarian meals', _vegetarian, (val) {
                        setState(() {
                          _vegetarian = val;
                        });
                      }),
                  _buildSwitchListTile('Vegan',
                      'Only include vegan meals', _vegan, (val) {
                        setState(() {
                          _vegan = val;
                        });
                      }),
                  _buildSwitchListTile('Lactose-free',
                      'Only include lactose-free meals', _lactoseFree, (val) {
                        setState(() {
                          _lactoseFree = val;
                        });
                      }),
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildSwitchListTile(
      String title, String subtitle, bool initialValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: initialValue,
      onChanged: updateValue,
      subtitle: Text(subtitle),
      selected: initialValue,
    );
  }
}
