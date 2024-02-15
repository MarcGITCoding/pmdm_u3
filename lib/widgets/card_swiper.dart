import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Meal> meals;

  const CardSwiper({Key? key, required this.meals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (meals.isEmpty) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Swiper(
          itemCount: meals.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.4,
          itemBuilder: (BuildContext context, int index) {
            final meal = meals[index];

            return GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, 'details', arguments: meal.id),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(meal.thumb ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ));
  }
}
