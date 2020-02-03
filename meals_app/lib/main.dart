import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/routes/routes.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal-detail-screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        '/': (ctxt) => TabsScreen(),
        Routes.CATEGORY_MEALS_SCREEN: (ctxt) => CategoryMealsScreen(),
        Routes.MEAL_DETAILS_SCREEN: (ctxt) => MealDetailScreen(),
        Routes.FILTERS_SCREEN: (ctxt) => FiltersScreen(),
      },
      onUnknownRoute: (settings)  {
        return MaterialPageRoute(builder: (ctxt) => CategoriesScreen());
      },
    );
  }
}

