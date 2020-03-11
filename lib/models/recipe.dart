class Recipe {
  final String spoonacularSourceUrl;
  Recipe({this.spoonacularSourceUrl});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      spoonacularSourceUrl: json['spoonacularSourceUrl'],
    );
  }
}
