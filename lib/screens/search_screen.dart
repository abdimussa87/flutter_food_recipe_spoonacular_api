import 'package:flutter/material.dart';
import 'package:food_recipe_spoonacular_api/models/meal_plan_model.dart';
import 'package:food_recipe_spoonacular_api/services/api_service.dart';

import 'meals_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> _diets = [
    "None",
    "Gluten Free",
    "Ketogenic",
    "Vegetarian",
    "Lacto-Vegetarian",
    "Ovo-Vegetarian",
    "Vegan",
    "Whole30",
  ];

  double _targetCalories = 2200;
  String _diet = "None";

  _searchMealPlan() async {
    MealPlan mealPlan = await APIService.instance.generateMealPlan(
      diet: _diet,
      targetCalories: _targetCalories.toInt(),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MealsScreen(mealPlan: mealPlan),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://images.unsplash.com/photo-1498837167922-ddd27525d352?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.9),
              borderRadius: BorderRadius.circular(
                15,
              ),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  "24 Hour Meal Plan",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                //Using richtext to make inline texts with different styling
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: _targetCalories.truncate().toString(),
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    TextSpan(
                      text: " cal",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor),
                    ),
                  ]),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbColor: Theme.of(context).primaryColor,
                    activeTrackColor: Theme.of(context).primaryColor,
                    trackHeight: 6,
                  ),
                  child: Slider.adaptive(
                    value: _targetCalories,
                    onChanged: (newValue) {
                      setState(() {
                        _targetCalories = newValue;
                      });
                    },
                    min: 1.0,
                    max: 4000,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: DropdownButtonFormField(
                    items: _diets.map(
                      (String diet) {
                        return DropdownMenuItem(
                          value: diet,
                          child: Text(
                            diet,
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        _diet = value;
                      });
                    },
                    value: _diet,
                    decoration: InputDecoration(
                      labelText: "Diet",
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FlatButton(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 40,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: _searchMealPlan,
                  child: Text(
                    "Search",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
