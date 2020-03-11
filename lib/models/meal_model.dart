class Meal{
  final int id;
  final String title;
  final String imageUrl;

  Meal({this.id,this.title,this.imageUrl});
  factory Meal.fromJson(Map<String,dynamic> json){
    return Meal(id: json['id'],
    title: json['title'],
    imageUrl:  "https://api.spoonacular.com/recipeImages/" + json['image']);
  }
}