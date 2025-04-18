import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/data/data_source/bookmark/bookmark_data_source_impl.dart';
import 'package:recipe_app/data/data_source/recipe/recipe_data_source_impl.dart';
import 'package:recipe_app/data/data_source/steps/steps_data_source_impl.dart';
import 'package:recipe_app/data/repository/bookmark/bookmark_repository_impl.dart';
import 'package:recipe_app/data/repository/recipe/recipe_repository_impl.dart';
import 'package:recipe_app/domain/use_case/saved_recipe/get_saved_recipes_use_case.dart';
import 'package:recipe_app/presentation/main/home/home_screen.dart';
import 'package:recipe_app/presentation/main/main_screen.dart';
import 'package:recipe_app/presentation/saved_recipes/saved_recipes_screen.dart';
import 'package:recipe_app/presentation/saved_recipes/saved_recipes_view_model.dart';
import 'package:recipe_app/presentation/sign_in/sign_in_screen.dart';
import 'package:recipe_app/presentation/sign_up/sign_up_screen.dart';
import 'package:recipe_app/presentation/splash/splash_screen.dart';
import 'package:recipe_app/routes.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: Routes.signIn,
      builder: (context, state) => const SignInScreen(),
    ),

    GoRoute(
      path: Routes.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              navigationShell.goBranch(index);
            },
            selectedIndex: navigationShell.currentIndex,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.bookmark), label: 'Saved'),
              NavigationDestination(
                icon: Icon(Icons.notifications),
                label: 'Notification',
              ),
              NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
            ],
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
                  (context, state) => SavedRecipesScreen(
                    savedRecipesViewModel: SavedRecipesViewModel(
                      GetSavedRecipesUseCase(
                        bookmarkRepository: BookmarkRepositoryImpl(
                          BookmarkDataSourceImpl(),
                        ),
                        recipeRepository: RecipeRepositoryImpl(
                          RecipeDataSourceImpl(),
                          StepsDataSourceImpl(),
                        ),
                      ),
                      RecipeRepositoryImpl(
                        RecipeDataSourceImpl(),
                        StepsDataSourceImpl(),
                      ),
                    ),
                  ),
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
