import 'package:flutter/material.dart';
import 'package:recipe_app/ui/color_style.dart';

class MainScreen extends StatelessWidget {
  final Widget child;
  final Widget bottomNavigationBar;
  const MainScreen({
    super.key,
    required this.child,
    required this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorStyle.primary100,
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: ColorStyle.white),
      ),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
