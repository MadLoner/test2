import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test2/data/models/category_model.dart';
import 'package:test2/data/models/sneaker_model.dart';
import 'package:test2/domain/functions/functions.dart';
import 'package:test2/presentation/colors/color.dart';
import 'package:test2/presentation/pages/categories_page.dart';
import 'package:test2/presentation/pages/favorite_page.dart';
import 'package:test2/presentation/pages/home_page.dart';
import 'package:test2/presentation/pages/popular_page.dart';
import 'package:test2/presentation/widgets/bottom_nav_bar.dart';
import 'package:test2/presentation/widgets/category_item.dart';
import 'package:test2/presentation/widgets/sneaker_item.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

int selectedIndex = 0;
PageController pageController = PageController();

class _HomePageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: MyColors.backgroundColor,
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        children: [
          HomePage(),
          FavoritePage(),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        controller: pageController,
        index: selectedIndex,
      ),
    );
  }
}
