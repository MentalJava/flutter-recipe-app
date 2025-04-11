import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipe_app/model/ingredients.dart';
import 'package:recipe_app/model/pictures.dart';
import 'package:recipe_app/presentation/component/button/enum/category.dart';

part 'recipe.freezed.dart';

// ignore_for_file: annotate_overrides

@freezed
class Recipe with _$Recipe {
  final int id;
  final String title;
  final Pictures pictures;
  final Category category;
  final double rating;
  final int time;
  final String chef;
  final List<Ingredients> ingredients;

  Recipe({
    required this.id,
    required this.title,
    required this.pictures,
    required this.rating,
    required this.time,
    required this.chef,
    required this.ingredients,
    required this.category,
  });
}
