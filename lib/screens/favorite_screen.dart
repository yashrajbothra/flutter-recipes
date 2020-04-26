import 'package:flutter/material.dart';
import 'package:recipes/models/meals.dart';
import 'package:recipes/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  List<Meal> _favMeals;
  FavoritesScreen(this._favMeals);
  @override
  Widget build(BuildContext context) {
    if (_favMeals.isEmpty) {
      return Center(
        child: Text("You have no favorites yet"),
      );
    }else{
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: _favMeals[index].id,
            title: _favMeals[index].title,
            imageUrl: _favMeals[index].imageUrl,
            duration: _favMeals[index].duration,
            affordability: _favMeals[index].affordability,
            complexity: _favMeals[index].complexity,
            bgColor: Theme.of(context).accentColor,
          );
        },
        itemCount: _favMeals.length,
      );
    }
  }
}
