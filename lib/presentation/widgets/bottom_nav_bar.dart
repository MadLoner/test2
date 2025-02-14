import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test2/presentation/colors/color.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {super.key, required this.index, required this.controller});

  final int index;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/background_nav.png',
        ),
        GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/cart_nav.png',
                width: 100,
                height: 100,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 52, left: 31, right: 31),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => controller.animateToPage(
                      0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                    child: SvgPicture.asset(
                      'assets/home_nav.svg',
                      width: 24,
                      height: 24,
                      color: index == 0
                          ? MyColors.accentColor
                          : MyColors.hintColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 41),
                    child: GestureDetector(
                      onTap: () => controller.animateToPage(
                        1,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      ),
                      child: SvgPicture.asset(
                        'assets/heart_nav.svg',
                        width: 24,
                        height: 24,
                        color: index == 1
                            ? MyColors.accentColor
                            : MyColors.hintColor,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => controller.animateToPage(
                      2,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                    child: SvgPicture.asset(
                      'assets/notification_nav.svg',
                      width: 24,
                      height: 24,
                      color: index == 2
                          ? MyColors.accentColor
                          : MyColors.hintColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: GestureDetector(
                      onTap: () => controller.animateToPage(
                        3,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      ),
                      child: SvgPicture.asset(
                        'assets/profile_nav.svg',
                        width: 24,
                        height: 24,
                        color: index == 3
                            ? MyColors.accentColor
                            : MyColors.hintColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
