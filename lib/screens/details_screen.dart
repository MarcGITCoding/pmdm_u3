import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/meals_provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String mealId = ModalRoute.of(context)?.settings.arguments as String;

    final mealsProvider = Provider.of<MealsProvider>(context, listen: false);
    return FutureBuilder(
      future: mealsProvider.getMealById(mealId),
      builder: (BuildContext context, AsyncSnapshot<Meal> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final Meal meal = snapshot.data!;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _CustomAppBar(meal: meal),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _ThumbAndMealName(meal: meal),
                    _Overview(meal: meal),
                    IngredientsCards(ingredients: meal.ingredients),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Meal meal;

  const _CustomAppBar({required this.meal});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            meal.name,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(meal.thumb ?? ''),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _ThumbAndMealName extends StatelessWidget {
  final Meal meal;

  const _ThumbAndMealName({required this.meal});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(meal.thumb ?? ''),
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.name,
                  style: textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Meal meal;

  const _Overview({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        meal.instructions ?? '',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
