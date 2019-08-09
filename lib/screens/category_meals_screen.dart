import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeal;
  var _loadedInitData = false;

  @override
  void initState() {
   
    super.initState();
  }

@override
  void didChangeDependencies() {
    if(!_loadedInitData){
      final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
              categoryTitle = routeArgs['title'];
              final categoryId = routeArgs['id'];

              displayedMeal = widget.availableMeals.where((meal) {
                return meal.categories.contains(categoryId);
              }).toList();

      _loadedInitData = true;
    }
     
    super.didChangeDependencies();
  }


  void _removeMeal(String mealId){
    setState(() {
     displayedMeal.removeWhere((meal)=> meal.id == mealId); 
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeal[index].id,
            title: displayedMeal[index].title,
            affordability: displayedMeal[index].affordability,
            complexity: displayedMeal[index].complexity,
            duration: displayedMeal[index].duration,
            imageUrl: displayedMeal[index].imageUrl,
            removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeal.length,
      ),
    );
  }
}
