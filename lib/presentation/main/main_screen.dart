import 'package:flutter/material.dart';

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
    return Scaffold(body: child, bottomNavigationBar: bottomNavigationBar);
  }
}
