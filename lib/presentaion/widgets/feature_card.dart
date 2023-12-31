import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final String price;
  final int rating;
  final Function() onPressed;

  const FeatureCard(
      {super.key,
      required this.price,
      required this.image,
      required this.title,
      required this.description,
      required this.rating,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 250.0,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.outlineColor.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  image,
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: generateRatingIcons(rating, 5)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      price,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.outlineColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to generate rating icons dynamically
  List<Widget> generateRatingIcons(int rating, int maxRating) {
    List<Widget> icons = [];

    for (int i = 0; i < rating; i++) {
      icons.add(
        Icon(
          Icons.star_rounded,
          color: Colors.yellow,
        ),
      );
    }

    for (int i = rating; i < maxRating; i++) {
      icons.add(
        Icon(
          Icons.star_outline,
          color: Colors.white,
        ),
      );
    }

    return icons;
  }
}
