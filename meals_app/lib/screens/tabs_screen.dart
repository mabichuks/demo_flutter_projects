import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favourites_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {

  final List<Meal> favourites;
  TabsScreen(this.favourites);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
   List<Map<String, dynamic>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'} ,
      {'page': FavouritesScreen(widget.favourites), 'title': 'Your Favourites'}
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      body: _pages[_selectedPageIndex]['page'],
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text('Categories')),
          BottomNavigationBarItem(
              icon: Icon(Icons.star), title: Text('Favourites'))
        ],
      ),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
}
