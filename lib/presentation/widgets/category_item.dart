import 'package:flutter/material.dart';
import 'package:test2/presentation/colors/color.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: MyColors.blockColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(title),
    );
  }
}
