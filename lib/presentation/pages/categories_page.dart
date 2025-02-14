import 'package:flutter/material.dart';
import 'package:test2/data/models/category_model.dart';
import 'package:test2/data/models/sneaker_model.dart';
import 'package:test2/domain/functions/functions.dart';
import 'package:test2/presentation/colors/color.dart';
import 'package:test2/presentation/widgets/category_item.dart';
import 'package:test2/presentation/widgets/sneaker_item.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage(
      {super.key, required this.title, required this.catIndex});

  final String title;
  final int catIndex;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

String titleWidget = '';
int selectedIndex = 0;

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  void initState() {
    selectedIndex = widget.catIndex;
    titleWidget = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          titleWidget,
          style: TextStyle(fontSize: 16, color: MyColors.textColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: [
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
                          isSelected: categories[index].name == titleWidget
                              ? true
                              : false,
                          title: categories[index].name,
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              titleWidget = categories[index].name;
                            });
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Center(
                child: FutureBuilder<List<SneakerModel>>(
                  future: Functions.getSneakersCategory(selectedIndex + 1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No sneakers found.'));
                    } else {
                      final sneakers = snapshot.data!;
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: sneakers.length,
                        itemBuilder: (context, index) {
                          return SneakerItem(
                              isBestSeller: sneakers[index].bestseller,
                              uuid: sneakers[index].id,
                              isPopular: true,
                              fullname: sneakers[index].name,
                              price: sneakers[index].price.toString());
                        },
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
