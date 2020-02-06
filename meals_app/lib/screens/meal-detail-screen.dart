import 'package:flutter/material.dart';
import 'package:meals_app/app_config.dart';
import 'package:meals_app/models/dummydata.dart';

class MealDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;

    final mealId = routeArgs['id'];

    final meal = DUMMY_MEALS.firstWhere((m) => m.id == mealId);
    AppConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${meal.title}'),
      ),
      body:
         SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: AppConfig.safeBlockVertical * 40,
                width: double.infinity,
                child: Image.network(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              buildSectionTitle(context, 'Ingredients'),
              buildContainer(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListView.builder(
                      itemBuilder: (ctxt, index) => Card(
                            color: Theme.of(context).accentColor,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              child: Text(meal.ingredients[index]),
                            ),
                          ),
                      itemCount: meal.ingredients.length),
                ),
              ),
              buildSectionTitle(context, 'Steps'),
              buildContainer(
                  child: ListView.builder(
                itemBuilder: (ctxt, index) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(child: Text('# ${index + 1}')),
                      title: Text(meal.steps[index]),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: meal.steps.length,
              ))
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.delete
        ),
        onPressed: () => Navigator.of(context).pop(mealId),
      ),
    );
  }

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer({Widget child}) {
    return Container(
      height: (AppConfig.safeBlockVertical * 30) - 20,
      width: AppConfig.safeBlockHorizontal * 80,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      child: child,
    );
  }
}
