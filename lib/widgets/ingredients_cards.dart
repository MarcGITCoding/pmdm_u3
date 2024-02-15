import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';

class IngredientsCards extends StatelessWidget {
  final List<Ingredient> ingredients;

  const IngredientsCards({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 180,
      // color: Colors.red,
      child: ListView.builder(
          itemCount: ingredients.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) =>
              _IngredientCard(ingredient: ingredients[index])),
    );
  }
}

class _IngredientCard extends StatelessWidget {
  final Ingredient ingredient;

  const _IngredientCard({required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 150,
      height: 150,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(ingredient.thumb),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            ingredient.name ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          Text(
            ingredient.measure ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
