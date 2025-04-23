import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/core/di/di_setup.dart';
import 'package:recipe_app/presentation/main/home/home_screen.dart';
import 'package:recipe_app/presentation/main/main_screen.dart';
import 'package:recipe_app/presentation/main/ingredient/ingredient_screen.dart';
import 'package:recipe_app/presentation/saved_recipes/saved_recipes_screen.dart';
import 'package:recipe_app/presentation/search_recipes/search_recipes_screen.dart';
import 'package:recipe_app/presentation/sign_in/sign_in_screen.dart';
import 'package:recipe_app/presentation/sign_up/sign_up_screen.dart';
import 'package:recipe_app/presentation/splash/splash_screen.dart';
import 'package:recipe_app/core/routing/routes.dart';
import 'package:recipe_app/ui/color_style.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => SplashScreen(getIt()),
    ),

    GoRoute(
      path: Routes.signIn,
      builder: (context, state) => const SignInScreen(),
    ),

    GoRoute(
      path: Routes.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),

    GoRoute(
      path: Routes.search,
      builder: (context, state) => SearchRecipesScreen(viewModel: getIt()),
    ),

    GoRoute(
      path: '${Routes.savedDetail}/:id',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '');
        return IngredientScreen(recipeId: id!, ingredientViewModel: getIt());
      },
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(
          bottomNavigationBar: CustomBottomAppBar(
            selectedIndex: navigationShell.currentIndex,
            onChanged: (value) {
              navigationShell.goBranch(value);
            },
          ),
          child: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.saved,
              builder:
                  (context, state) =>
                      SavedRecipesScreen(savedRecipesViewModel: getIt()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.notification,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.profile,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class CustomBottomAppBar extends StatelessWidget {
  final ValueChanged<int> onChanged;
  final int selectedIndex;
  const CustomBottomAppBar({
    super.key,
    required this.onChanged,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: ColorStyle.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIcon(0, 'home'),
          _buildIcon(1, 'bookmark'),
          const SizedBox(width: 24),
          _buildIcon(2, 'notification'),
          _buildIcon(3, 'profile'),
        ],
      ),
    );
  }

  Widget _buildIcon(int index, String name) {
    final isSelected = index == selectedIndex;
    final imageName = isSelected ? '${name}_fill' : name;
    final path = 'assets/images/home/$imageName.png';
    return GestureDetector(
      child: Image.asset(path),
      onTap: () => onChanged(index),
    );
  }
}
