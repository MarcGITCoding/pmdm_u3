import 'package:movies_app/models/models.dart';

class Meal {
  String id;
  String name;
  dynamic drinkAlternate;
  String? category;
  String? area;
  String? instructions;
  String thumb;
  String? tags;
  String? youtubeVideo;
  dynamic source;
  dynamic sourceImage;
  dynamic creativeCommonsConfirmed;
  dynamic dateModified;
  List<Ingredient> ingredients;

  Meal({
    required this.id,
    required this.name,
    required this.drinkAlternate,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumb,
    required this.tags,
    required this.youtubeVideo,
    required this.source,
    required this.sourceImage,
    required this.creativeCommonsConfirmed,
    required this.dateModified,
    required this.ingredients,
  });

  factory Meal.fromJson(String str) => Meal.fromMap(json.decode(str));

  factory Meal.fromMap(Map<String, dynamic> json) {
    List<Ingredient> ingredients = [];

    //Formateador de los ingredientes
    for (int i = 1; i <= 20; i++) {
      final name = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      // Si encuentra un string vacío o nulo, termina el bucle
      if (name == null || name.isEmpty || measure == null || measure.isEmpty) {
        break;
      }

      ingredients.add(Ingredient(name: name, measure: measure));
    }

    return Meal(
      id: json["idMeal"],
      name: json["strMeal"],
      drinkAlternate: json["strDrinkAlternate"],
      category: json["strCategory"],
      area: json["strArea"],
      instructions: json["strInstructions"],
      thumb: json["strMealThumb"],
      tags: json["strTags"],
      youtubeVideo: json["strYoutube"],
      source: json["strSource"],
      sourceImage: json["strImageSource"],
      creativeCommonsConfirmed: json["strCreativeCommonsConfirmed"],
      dateModified: json["dateModified"],
      ingredients: ingredients,
    );
  }
}
