import 'package:flutter/material.dart';
import 'package:food_recipe_spoonacular_api/screens/search_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      theme: ThemeData(
        primaryColor: Colors.orange[300],
      ),
      home: SearchScreen(),
    );
  }
}

