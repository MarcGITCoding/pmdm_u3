import 'package:flutter/material.dart';
import 'package:movies_app/providers/meals_provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mealsProvider = Provider.of<MealsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals List'),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // Tarjetas principales
              CardSwiper(meals: mealsProvider.globalDisplayMeals),

              // Slider de meals regionales
              MealSlider(meals: mealsProvider.globalRegionalMeals),
            ],
          ),
        ),
      ),
    );
  }
}
