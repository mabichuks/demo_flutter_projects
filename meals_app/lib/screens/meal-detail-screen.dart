import 'package:flutter/material.dart';
import 'package:meals_app/models/dummydata.dart';


class MealDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;

    final mealId = routeArgs['id'];

    final meal = DUMMY_MEALS.firstWhere((m) => m.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text('${meal.title}'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(meal.imageUrl, fit: BoxFit.cover,),
            )
          ],
        ),
      ),
    );
  }

}