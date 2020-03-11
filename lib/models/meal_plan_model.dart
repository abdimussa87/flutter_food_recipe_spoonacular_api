import 'meal_model.dart';

class MealPlan {
  final List<Meal> meals;
  final double calories;
  final double carbohydrates;
  final double fat;
  final double protein;

  MealPlan({
    this.meals,
    this.calories,
    this.carbohydrates,
    this.fat,
    this.protein,
  });

  factory MealPlan.fromJson(Map<String, dynamic> json) {
    List<Meal> meals = [];
    List<dynamic> mealsJson = json['meals'];
    mealsJson.forEach(
      (meal) => meals.add(Meal.fromJson(meal)),
    );
    return MealPlan(
      meals: meals,
      calories: json['nutrients']['calories'],
      carbohydrates: json['nutrients']['carbohydrates'],
      fat: json['nutrients']['fat'],
      protein: json['nutrients']['protein'],
    );
  }
}
