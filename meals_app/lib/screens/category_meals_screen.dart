import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/models/dummydata.dart';

class CategoryMealsScreen extends StatelessWidget {

//  final String id;
//  final String title;
//  final Color color;

  //CategoryMealsScreen(this.id, this.title, this.color);

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final title = routeArgs['title'];
    final categoryId = routeArgs['id'];

    final categoryMeals = DUMMY_MEALS.where((meal) => meal.categories.contains(categoryId)).toList();

    return Scaffold(
      appBar: AppBar (
        title: Text(title),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (ctxt, index) {
          return Text(categoryMeals[index].title);
        },
          itemCount: categoryMeals.length,)
      ),
    );
  }

}