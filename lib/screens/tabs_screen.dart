import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';
import '../models/meal.dart';

class TabScreen extends StatelessWidget {
  final List<Meal> _favoriteMeals;
  TabScreen(this._favoriteMeals);
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.category,
                ),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favorites',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CategoriesScreen(),
            FavoritesScreen(_favoriteMeals),
          ],
        ),
      ),
    );
  }
}
