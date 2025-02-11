import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test2/presentation/colors/color.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      List<String> titles = ['Все', 'Outdoor', 'Tennis'];
                      return Container(
                        width: 150,
                        margin: EdgeInsets.only(right: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: MyColors.blockColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(titles[index]),
                      );
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
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: 2,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 50),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: MyColors.blockColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                              'assets/unheart.svg',
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/sneaker_item_image.png',
                                  width: 130,
                                  height: 70,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text('Best Seller'),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text('Nike Air Max'),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text('₽752.00'),
                                    GestureDetector(
                                      child: Image.asset(
                                        'assets/add_to_cart.png',
                                        width: 30,
                                        height: 30,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
