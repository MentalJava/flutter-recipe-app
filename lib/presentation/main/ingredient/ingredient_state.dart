import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipe_app/domain/model/recipe.dart';

part 'ingredient_state.freezed.dart';

// ignore_for_file: annotate_overrides
@freezed
class IngredientState with _$IngredientState {
  Recipe? recipe;
  final bool isLoading;
  final bool isBookmarked;
  final String errorMessage;
  final Set<int> bookmarkedRecipes;
  final int tabIndex;

  IngredientState({
    this.recipe,
    this.isLoading = false,
    this.errorMessage = '',
    this.bookmarkedRecipes = const {},
    this.isBookmarked = false,
    this.tabIndex = 0,
  });
}
