import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {

  final String id;
  final String title;
  final Color color;

  CategoryMealsScreen(this.id, this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'The $title recipe for the category'
        ),
      ),
    );
  }

}