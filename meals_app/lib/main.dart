import 'package:flutter/material.dart';
import 'package:meals_app/models/dummydata.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/routes/routes.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal-detail-screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String, bool> _filters = {
    'gluten': false,
    'vegetarian' : false,
    'vegan' : false,
    'lactose' : false,
  };

  void _toggleFavourites(String mealId) {
    final int existingIndex = _favouriteMeals.indexWhere((meal)=> meal.id == mealId);
    if(existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavourite(String mealId) {
    return _favouriteMeals.any((meal) => meal.id == mealId);
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((val) {
        if(_filters['gluten'] && !val.isGlutenFree) {
          return false;
        }
        if(_filters['vegetarian'] && !val.isVegetarian) {
          return false;
        }
        if(_filters['vegan'] && !val.isVegan) {
          return false;
        }
        if(_filters['lactose'] && !val.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1)
          ),
          body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1)
          ),
          title: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold
          )
        ),
      ),
      //home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctxt) => TabsScreen(_favouriteMeals),
        Routes.CATEGORY_MEALS_SCREEN: (ctxt) => CategoryMealsScreen(_availableMeals),
        Routes.MEAL_DETAILS_SCREEN: (ctxt) => MealDetailScreen(_toggleFavourites, _isMealFavourite),
        Routes.FILTERS_SCREEN: (ctxt) => FiltersScreen(_filters, _setFilters),
      },
      onUnknownRoute: (settings)  {
        return MaterialPageRoute(builder: (ctxt) => CategoriesScreen());
      },
    );
  }
}

