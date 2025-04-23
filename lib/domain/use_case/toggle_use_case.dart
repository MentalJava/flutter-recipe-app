import 'package:recipe_app/domain/repository/recipe/recipe_repository.dart';

class ToggleUseCase {
  final RecipeRepository _recipeRepository;

  ToggleUseCase({required RecipeRepository recipeRepository})
    : _recipeRepository = recipeRepository;

  void excute(int id) {
    _recipeRepository.toggle(id);
  }
}
