import 'package:flutter/material.dart';
import './screens/filters_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/tabs_screen_bottom.dart';
import 'dummy_data.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String,bool> _filters = {
    'gluten': false,
    'lactose':false,
    'vegan':false,
    'vegetarian':false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String,bool> filterData){
    setState(() {
     _filters = filterData; 
     _availableMeals = DUMMY_MEALS.where((meal){
      if(_filters['gluten'] && !meal.isGlutenFree){
        return false;
      }
      if(_filters['lactose'] && !meal.isLactoseFree){
        return false;
      }
      if(_filters['vegan'] && !meal.isVegan){
        return false;
      }
      if(_filters['vegetarian'] && !meal.isVegetarian){
        return false;
      }
      return true;
     }).toList();
    });
  }

void _toggleFavorite(String mealId){
    //indexWhere find mealId in favoriteMeals and get the index. it return the index = -1 if not found
    final foundInIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    //if mealId found in favoriteMeals than remove (because it is toggle)
    if(foundInIndex >= 0){
      setState(() {
        _favoriteMeals.removeAt(foundInIndex); 
      });
    }else{//if mealId not found in favoriteMeals than add
        setState(() {
          _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId)); 
        });
    }

}

bool _isMealFavorite(String mealId){
  return _favoriteMeals.any((meal)=> meal.id ==mealId);
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DailyMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 52, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: CategoriesScreen(),
      routes: {
        // '/': (ctx) => TabScreen(),
        '/': (ctx)=> TabsScreenBottom(_favoriteMeals),
        '/category-meals': (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters,_setFilters),
      },
      onGenerateRoute: (settings){
        print(settings.arguments);
      },
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx)=> CategoriesScreen());
      },
    );
  }
}
