import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    final meal = routeArgs['meal'] as MealItem;

    return Scaffold(
      appBar: AppBar(
        title: Text('${meal.title}'),
      ),
      body: Center(
        child: Text('${meal.title} Meal details'),
      ),
    );
  }

}