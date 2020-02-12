import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';

class ProductItem extends StatelessWidget  {
  
//  final String id;
//  final String title;
//  final String imageUrl;
//
//  ProductItem(this.id, this.title, this.imageUrl);


  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);


    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.network(product.imageUrl, fit: BoxFit.cover,),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(product.isFavourite ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).accentColor,
            onPressed: () => product.toggleFavouriteStatus(),

          ),
          backgroundColor: Colors.black87,
          title: Text(product.title, textAlign: TextAlign.center,),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }

}