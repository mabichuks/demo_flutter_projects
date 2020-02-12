import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final loadedProducts = Provider.of<ProductProvider>(context).items;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (c, i) => ChangeNotifierProvider(
        create: (ctxt) => loadedProducts[i],
        child: ProductItem(),
      ),
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
    );
  }
}
