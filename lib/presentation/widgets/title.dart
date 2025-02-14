import 'package:flutter/material.dart';
import 'package:test2/presentation/colors/color.dart';

Widget tile(String title, Function()? onTap) {
  var tile = GestureDetector(
    onTap: onTap,
    child: Container(
      width: 150,
      margin: EdgeInsets.only(right: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: MyColors.blockColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(title),
    ),
  );
  return tile;
}
