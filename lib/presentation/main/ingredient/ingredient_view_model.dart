import 'package:flutter/foundation.dart';
import 'package:recipe_app/domain/use_case/saved_recipe/get_saved_recipe_detail_use_case.dart';
import 'package:recipe_app/domain/use_case/toggle_use_case.dart';
import 'package:recipe_app/presentation/main/ingredient/ingredient_state.dart';

class IngredientViewModel with ChangeNotifier {
  final GetSavedRecipeDetailUseCase _getSavedRecipeDetailUseCase;

  IngredientViewModel({
    required GetSavedRecipeDetailUseCase getSavedRecipeDetailUseCase,
    required ToggleUseCase toggleUseCase,
  }) : _getSavedRecipeDetailUseCase = getSavedRecipeDetailUseCase;

  IngredientState _state = IngredientState();
  IngredientState get state => _state;

  Future<void> savedRecipe(int recipeId) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    try {
      final recipe = await _getSavedRecipeDetailUseCase.excute(recipeId);
      _state = state.copyWith(recipe: recipe);
    } catch (e) {
      _state = state.copyWith(errorMessage: e.toString());
    }
    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }

  void changeTab(int index) {
    _state = state.copyWith(tabIndex: index);
    notifyListeners();
  }
}
