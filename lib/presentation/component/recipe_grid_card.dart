import 'package:flutter/material.dart';
import 'package:recipe_app/domain/model/recipe.dart';
import 'package:recipe_app/ui/color_style.dart';
import 'package:recipe_app/ui/text_font_style.dart';

class RecipeGridCard extends StatelessWidget {
  const RecipeGridCard({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.network(recipe.pictures.imageUrl, fit: BoxFit.cover),
          ),
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black87],
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            decoration: BoxDecoration(
              color: ColorStyle.secondary20,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              child: Row(
                spacing: 3,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: ColorStyle.rating, size: 12),
                  Text(
                    recipe.rating.toString(),
                    style: TextFontStyle.smallRegular().copyWith(fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  recipe.title,
                  style: TextFontStyle.smallBold(
                    color: ColorStyle.white,
                  ).copyWith(fontSize: 11),
                ),
              ),
              Text(
                'by ${recipe.chef}',
                style: TextFontStyle.extraSmallRegular(
                  color: ColorStyle.white,
                ).copyWith(fontSize: 8),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
