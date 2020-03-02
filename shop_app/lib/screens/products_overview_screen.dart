import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/widgets/products-grid.dart';


enum FilterOptions { Favourite, All}

class ProductsOverview extends StatefulWidget {


  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {

  bool _showOnlyFavourites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton<FilterOptions>(
            onSelected: (val) {
              setState(() {
                if(val == FilterOptions.Favourite)_showOnlyFavourites = true;
                else _showOnlyFavourites = false;
              });
            },
            child: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favourites'),
                value: FilterOptions.Favourite,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ]
          ),
        ],
      ),
      body:  ProductsGrid(_showOnlyFavourites),
    );
  }
}

