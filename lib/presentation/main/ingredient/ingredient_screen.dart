import 'package:flutter/material.dart';
import 'package:recipe_app/presentation/component/button/custom_button.dart';
import 'package:recipe_app/presentation/component/button/small_button.dart';
import 'package:recipe_app/presentation/component/ingredient_item.dart';
import 'package:recipe_app/presentation/component/recipe_detail_card.dart';
import 'package:recipe_app/presentation/component/step_card.dart';
import 'package:recipe_app/presentation/component/tabs.dart';
import 'package:recipe_app/presentation/main/ingredient/ingredient_view_model.dart';

import 'package:recipe_app/ui/color_style.dart';
import 'package:recipe_app/ui/text_font_style.dart';

class IngredientScreen extends StatefulWidget {
  final IngredientViewModel _ingredientViewModel;
  final int recipeId;

  const IngredientScreen({
    super.key,
    required this.recipeId,
    required IngredientViewModel ingredientViewModel,
  }) : _ingredientViewModel = ingredientViewModel;

  @override
  State<IngredientScreen> createState() => _SavedRecipesDetailViewState();
}

class _SavedRecipesDetailViewState extends State<IngredientScreen> {
  @override
  void initState() {
    super.initState();
    widget._ingredientViewModel.savedRecipe(widget.recipeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        scrolledUnderElevation: 0,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
        ],
      ),
      body: ListenableBuilder(
        listenable: widget._ingredientViewModel,
        builder: (context, snapshot) {
          if (widget._ingredientViewModel.state.recipe == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              spacing: 10,
              children: [
                RecipeDetailCard(
                  recipe: widget._ingredientViewModel.state.recipe!,
                  isBookmarked: widget
                      ._ingredientViewModel
                      .state
                      .bookmarkedRecipes
                      .contains(widget.recipeId),
                  onBookmarkToggle: () {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 180,
                      child: Text(
                        widget._ingredientViewModel.state.recipe!.title,
                        style: TextFontStyle.smallBold(),
                      ),
                    ),
                    Text(
                      '(13K Reviews)',
                      style: TextFontStyle.smallRegular(
                        color: ColorStyle.gray4,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        spacing: 10,
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.network(
                              widget
                                  ._ingredientViewModel
                                  .state
                                  .recipe!
                                  .pictures
                                  .imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Laura Wilson',
                                style: TextFontStyle.smallBold(),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_rounded,
                                    color: ColorStyle.primary100,
                                  ),
                                  Text(
                                    widget
                                        ._ingredientViewModel
                                        .state
                                        .recipe!
                                        .address,
                                    style: TextFontStyle.extraSmallRegular(
                                      color: ColorStyle.gray3,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CustomButton(text: 'Follow', onTap: () {}, width: 85),
                  ],
                ),
                Tabs(
                  labels: const ['Ingredient', 'Procedure'],
                  onValueChange: (index) {
                    widget._ingredientViewModel.changeTab(index);
                  },
                  selectedIndex: widget._ingredientViewModel.state.tabIndex,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.room_service_outlined,
                          color: ColorStyle.gray3,
                        ),
                        Text(
                          '1 serve',
                          style: TextFontStyle.extraSmallRegular(
                            color: ColorStyle.gray3,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '10 Items',
                      style: TextFontStyle.extraSmallRegular(
                        color: ColorStyle.gray3,
                      ),
                    ),
                  ],
                ),
                widget._ingredientViewModel.state.tabIndex == 0
                    ? Expanded(
                      child: ListView.builder(
                        itemCount:
                            widget
                                ._ingredientViewModel
                                .state
                                .recipe!
                                .ingredients
                                .length,
                        itemBuilder: (context, index) {
                          final item =
                              widget
                                  ._ingredientViewModel
                                  .state
                                  .recipe!
                                  .ingredients[index];
                          return IngredientItem(
                            item: item.ingredient,
                            amount: item.amount,
                          );
                        },
                      ),
                    )
                    : Expanded(
                      child: ListView.builder(
                        itemCount:
                            widget
                                ._ingredientViewModel
                                .state
                                .recipe!
                                .step
                                .length,
                        itemBuilder: (context, index) {
                          final step =
                              widget
                                  ._ingredientViewModel
                                  .state
                                  .recipe!
                                  .step[index];
                          return StepCard(
                            index: step.step,
                            content: step.content,
                          );
                        },
                      ),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
