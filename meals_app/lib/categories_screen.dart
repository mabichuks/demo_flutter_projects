import 'package:flutter/material.dart';

import 'category_item.dart';
import 'models/dummydata.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deli Meals'),
      ),
      body: GridView(
        children: DUMMY_CATEGORIES.map((data) => CategoryItem(data.title, data.color)).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20
        ),
      ),
    );
  }

}