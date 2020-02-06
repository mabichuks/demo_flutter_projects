import 'package:flutter/material.dart';
import 'package:meals_app/models/dummydata.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
//  final String id;
//  final String title;
//  final Color color;

  //CategoryMealsScreen(this.id, this.title, this.color);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  String title;
  List<Meal> categoryMeals;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    if (!_isLoaded) {
      final routeArgs =
      ModalRoute.of(context).settings.arguments as Map<String, String>;
       title = routeArgs['title'];
      final categoryId = routeArgs['id'];

       categoryMeals = DUMMY_MEALS
          .where((meal) => meal.categories.contains(categoryId))
          .toList();
       _isLoaded = true;
    }

    super.didChangeDependencies();
  }

  void _removeItem(String mealId) {
    setState(() {
      categoryMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
          child: ListView.builder(
        itemBuilder: (ctxt, index) {
          return MealItem(
            id: categoryMeals[index].id,
              title: categoryMeals[index].title,
              imageUrl: categoryMeals[index].imageUrl,
              duration: categoryMeals[index].duration,
              affordability: categoryMeals[index].affordability,
              complexity: categoryMeals[index].complexity,
              removeItem: _removeItem,
          );
        },
        itemCount: categoryMeals.length,
      )),
    );
  }
}
