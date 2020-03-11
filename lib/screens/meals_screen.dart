import 'package:flutter/material.dart';
import 'package:food_recipe_spoonacular_api/models/meal_model.dart';
import 'package:food_recipe_spoonacular_api/models/meal_plan_model.dart';
import 'package:food_recipe_spoonacular_api/models/recipe.dart';
import 'package:food_recipe_spoonacular_api/screens/recipe_screen.dart';
import 'package:food_recipe_spoonacular_api/services/api_service.dart';

class MealsScreen extends StatefulWidget {
  final MealPlan mealPlan;
  MealsScreen({this.mealPlan});
  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your meal plan"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 140,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Total Nutrients",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Calories: ${widget.mealPlan.calories} cal",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Proteins: ${widget.mealPlan.protein} g",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Fat: ${widget.mealPlan.fat} g",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Carbohydrate: ${widget.mealPlan.carbohydrates} g",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.mealPlan.meals.length,
              itemBuilder: (context, int index) {
                Meal meal = widget.mealPlan.meals[index];
                return _buildMealCard(meal, index);
              }),
        ],
      ),
    );
  }

  Widget _buildMealCard(Meal meal, int index) {
    String mealType;
    switch (index) {
      case 0:
        mealType = "BreakFast";
        break;
      case 1:
        mealType = "Lunch";
        break;
      case 2:
        mealType = "Dinner";
        break;
    }
    return GestureDetector(
      onTap: () async {
        Recipe recipe =
            await APIService.instance.fetchRecipe(meal.id.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => RecipeScreen(
                      mealType: mealType,
                      recipe: recipe,
                    )));
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 240,
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(
                  meal.imageUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(60),
            //padding: EdgeInsets.all(10),
            color: Colors.white70,
            child: Column(
              children: <Widget>[
                Text(
                  mealType,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  meal.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
