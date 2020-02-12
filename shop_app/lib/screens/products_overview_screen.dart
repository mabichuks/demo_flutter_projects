import 'package:flutter/material.dart';
import 'package:shop_app/widgets/products-grid.dart';

class ProductsOverview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
      ),
      body: new ProductsGrid(),
    );
  }
}

