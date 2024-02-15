import 'package:movies_app/models/models.dart';

class SearchMeals {
  List<Meal> meals;

  SearchMeals({
    required this.meals,
  });

  factory SearchMeals.fromJson(String str) =>
      SearchMeals.fromMap(json.decode(str));

  factory SearchMeals.fromMap(Map<String, dynamic> json) => SearchMeals(
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromMap(x))),
      );
}
