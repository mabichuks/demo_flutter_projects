import 'package:flutter/cupertino.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {

  final List<Meal> favourites;

  FavouritesScreen(this.favourites);

  @override
  Widget build(BuildContext context) {
    if(favourites.isEmpty) {
      return Center(
        child: Text('You have no favourites'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctxt, index) {
          return MealItem(
            id: favourites[index].id,
            title: favourites[index].title,
            imageUrl: favourites[index].imageUrl,
            duration: favourites[index].duration,
            affordability: favourites[index].affordability,
            complexity: favourites[index].complexity,
          );
        },
        itemCount: favourites.length,
      );
    }

  }

}