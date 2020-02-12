import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';

class ProductDetailScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<ProductProvider>(context).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Center(),
    );

  }

}