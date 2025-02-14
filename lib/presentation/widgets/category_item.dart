import 'package:flutter/material.dart';
import 'package:test2/presentation/colors/color.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key,
      required this.title,
      required this.onTap,
      required this.isSelected});

  final String title;
  final Function()? onTap;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        margin: EdgeInsets.only(right: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: !isSelected! ? MyColors.blockColor : MyColors.accentColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: TextStyle(color: !isSelected! ? Colors.black : Colors.white),
        ),
      ),
    );
  }
}
