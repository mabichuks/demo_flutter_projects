import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {

  final bool showFavs;

  const ProductsGrid(this.showFavs);



  @override
  Widget build(BuildContext context) {

    final productProvider = Provider.of<ProductProvider>(context);
    final loadedProducts = showFavs ? productProvider.favouriteItems: productProvider.items;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (c, i) => ChangeNotifierProvider.value(
        value:  loadedProducts[i],
        child: ProductItem(),
      ),
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
    );
  }
}
