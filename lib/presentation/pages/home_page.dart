import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test2/data/models/category_model.dart';
import 'package:test2/data/models/sneaker_model.dart';
import 'package:test2/domain/functions/functions.dart';
import 'package:test2/presentation/colors/color.dart';
import 'package:test2/presentation/pages/categories_page.dart';
import 'package:test2/presentation/pages/popular_page.dart';
import 'package:test2/presentation/widgets/bottom_nav_bar.dart';
import 'package:test2/presentation/widgets/category_item.dart';
import 'package:test2/presentation/widgets/sneaker_item.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: MyColors.backgroundColor,
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/hamburger.svg'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Stack(
              alignment: Alignment.topRight,
              children: [
                SvgPicture.asset('assets/notification_dot.svg'),
                SvgPicture.asset('assets/cart_icon.svg'),
              ],
            ),
          ),
        ],
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SvgPicture.asset('assets/icon_title.svg'),
            ),
            Text(
              "Главная",
              style: TextStyle(fontSize: 32),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Material(
                        elevation: 3,
                        shadowColor: Colors.grey,
                        borderRadius: BorderRadius.circular(16),
                        child: GestureDetector(
                          onTap: () {},
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 26),
                                child: Image.asset(
                                  'assets/Icon.png',
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                              filled: true,
                              hintText: 'Поиск',
                              fillColor: MyColors.blockColor,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Material(
                        elevation: 2,
                        shape: CircleBorder(),
                        child: Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: MyColors.accentColor),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: SvgPicture.asset(
                              'assets/sliders.svg',
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 22,
                ),
                Row(
                  children: [
                    Text(
                      'Категории',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 22,
                ),
                SizedBox(
                  height: 50,
                  child: FutureBuilder<List<CategoryModel>>(
                    future: Functions.getCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No categories found.'));
                      } else {
                        final categories = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return CategoryItem(
                              isSelected: false,
                              title: categories[index].name,
                              onTap: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => CategoriesPage(
                                      catIndex: index,
                                      title: categories[index].name),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Популярное',
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PopularPage(),
                        ),
                      ),
                      child: Text(
                        'Все',
                        style: TextStyle(
                            fontSize: 16, color: MyColors.accentColor),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 200,
                  child: FutureBuilder<List<SneakerModel>>(
                    future: Functions.getPopularSneakers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No categories found.'));
                      } else {
                        final sneakers = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: sneakers.length,
                          itemBuilder: (context, index) {
                            return SneakerItem(
                                isBestSeller: sneakers[index].bestseller,
                                uuid: sneakers[index].id,
                                isPopular: false,
                                fullname: sneakers[index].name,
                                price: sneakers[index].price.toString());
                          },
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Акции',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Все',
                      style:
                          TextStyle(fontSize: 16, color: MyColors.accentColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset('assets/ad.png')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
