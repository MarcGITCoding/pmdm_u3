import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';

class MealsProvider extends ChangeNotifier {
  final String _baseUrl = 'www.themealdb.com';

  List<Meal> globalDisplayMeals = [];
  List<Meal> globalRegionalMeals = [];

  Map<String, Meal> cacheMeals = {};

  MealsProvider() {
    getOnDisplayMeals();
    getAreaMeals("Spanish");
  }

  //Meal por búsqueda
  getOnDisplayMeals() async {
    var url = Uri.https(_baseUrl, 'api/json/v1/1/search.php', {'f': 'a'});

    final result = await http.get(url);

    final searchMeals = SearchMeals.fromJson(result.body);

    globalDisplayMeals = searchMeals.meals;
    for (Meal meal in globalDisplayMeals) {
      if (meal.instructions != null) cacheMeals[meal.id] = meal;
    }

    notifyListeners();
  }

  //Meal por area
  getAreaMeals(String area) async {
    var url = Uri.https(_baseUrl, 'api/json/v1/1/filter.php', {'a': area});

    final result = await http.get(url);

    final searchMeals = SearchMeals.fromJson(result.body);

    globalRegionalMeals = searchMeals.meals;
    for (Meal meal in globalRegionalMeals) {
      if (meal.instructions != null) cacheMeals[meal.id] = meal;
    }

    notifyListeners();
  }

  //Meal por id
  Future<Meal> getMealById(String id) async {
    //Check de si ya está en la cache para no duplicar peticiones
    if (cacheMeals.containsKey(id)) {
      Meal meal = cacheMeals[id]!;
      return meal;
    }

    var url = Uri.https(_baseUrl, 'api/json/v1/1/lookup.php', {'i': id});

    final result = await http.get(url);

    final searchMeals = SearchMeals.fromJson(result.body);

    final meal = searchMeals.meals[0];

    cacheMeals[id] = meal;

    return meal;
  }
}
