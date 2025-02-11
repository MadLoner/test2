import 'package:flutter/material.dart';
import 'package:test2/presentation/colors/color.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.onTap,
      required this.title,
      required this.color,
      required this.titleColor});

  final Function()? onTap;
  final String title;
  final Color color;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color,
          ),
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'New Peninim MT',
                    fontSize: 12,
                    color: titleColor,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
