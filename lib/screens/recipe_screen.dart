import 'package:flutter/material.dart';
import 'package:food_recipe_spoonacular_api/models/recipe.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeScreen extends StatefulWidget {
  final String mealType;
  final Recipe recipe;

  const RecipeScreen({Key key, this.mealType, this.recipe}) : super(key: key);
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.recipe.spoonacularSourceUrl);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.mealType,
        ),
      ),
      body: WebView(
        initialUrl: widget.recipe.spoonacularSourceUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
