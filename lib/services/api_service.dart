import 'dart:convert';
import 'dart:io';


import 'package:food_recipe_spoonacular_api/models/meal_plan_model.dart';
import 'package:food_recipe_spoonacular_api/models/recipe.dart';
import 'package:http/http.dart' as http ;
class APIService {
  APIService._instantiate();
  static final APIService instance = APIService._instantiate();
  final String _baseURL = "https://api.spoonacular.com";
  static const String API_KEY = "2057b34fbdbf4c349f28f14889f37706";

  Future<MealPlan> generateMealPlan({int targetCalories, String diet}) async {
    if (diet == 'None') diet = '';
    Map<String, dynamic> parameters = {
      'timeFrame': 'day',
      'targetCalories': targetCalories,
      'diet': diet,
      'apiKey': API_KEY,
    };

    Uri uri = Uri.https(_baseURL,"/mealplanner/generate",parameters);
    Map<String,String> headers = {
      HttpHeaders.contentTypeHeader:"application/json",
    };
  try{

    var response = await http.get(uri,headers:headers );
    Map<String , dynamic> data = json.decode(response.body);
    MealPlan mealPlan = MealPlan.fromJson(data);
    return mealPlan;

  }catch(err){
    throw err.toString();
  }

  }

  Future<Recipe> fetchRecipe(String id)async{

    Map<String,String> parameters={
      "includeNutrition":"false",
      'apiKey': API_KEY,
    };

    Uri uri = Uri.https(_baseURL,"/recipes/$id/information",parameters );
    Map<String,String> headers = {
      HttpHeaders.contentTypeHeader:"application/json",
    };


    try{
    var response = await http.get(uri,headers:  headers);
    Map<String,dynamic> data = json.decode(response.body);
    Recipe recipe = Recipe.fromJson(data);
    return recipe;
    }
    catch(err){
      throw err.toString();
    }

    }

}
