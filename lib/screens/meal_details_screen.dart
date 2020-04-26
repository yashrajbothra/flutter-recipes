import 'package:flutter/material.dart';
import 'package:recipes/dummy_data.dart';

class MealDeatailsScreen extends StatelessWidget {
  static const routeName = '/meal_details';
  final Function toggleFav;
  final Function isMealFav;

  MealDeatailsScreen(this.toggleFav, this.isMealFav);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Text(
          text,
          style: Theme.of(context).textTheme.title,
        ),
      ),
    );
  }

  Widget buildContainer(BuildContext context, Widget child, height) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * height,
      width: MediaQuery.of(context).size.width * 0.85,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeals = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedMeals.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            child: Image.network(
              selectedMeals.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          buildSectionTitle(context, 'Ingredients'),
          buildContainer(
            context,
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.85,
              child: ListView.builder(
                itemBuilder: (ctx, index) => Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(selectedMeals.ingredients[index]),
                    )),
                itemCount: selectedMeals.ingredients.length,
              ),
            ),
            0.15,
          ),
          Container(child: buildSectionTitle(context, 'Steps')),
          buildContainer(
            context,
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.85,
              child: ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${(index + 1)}'),
                      ),
                      title: Text(selectedMeals.steps[index]),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
                itemCount: selectedMeals.steps.length,
              ),
            ),
            0.3,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isMealFav(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          toggleFav(mealId);
        },
      ),
    );
  }
}
