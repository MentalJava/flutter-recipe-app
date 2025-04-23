import 'package:flutter/material.dart';
import 'package:recipe_app/ui/color_style.dart';
import 'package:recipe_app/ui/text_font_style.dart';

class StepCard extends StatelessWidget {
  final int index;
  final String content;
  const StepCard({super.key, required this.index, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorStyle.gray4,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Step $index', style: TextFontStyle.extraSmallBold()),
          Text(
            content,
            style: TextFontStyle.extraSmallRegular(color: ColorStyle.gray3),
          ),
        ],
      ),
    );
  }
}
