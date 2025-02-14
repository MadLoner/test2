import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test2/data/models/sneaker_model.dart';
import 'package:test2/domain/functions/functions.dart';
import 'package:test2/presentation/colors/color.dart';
import 'package:test2/presentation/pages/favorite_page.dart';
import 'package:test2/presentation/pages/home_page.dart';
import 'package:test2/presentation/widgets/sneaker_item.dart';

class PopularPage extends StatefulWidget {
  const PopularPage({super.key});

  @override
  State<PopularPage> createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.backgroundColor,
        centerTitle: true,
        title: Container(
          width: MediaQuery.of(context).size.width - 20,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset(
                  'assets/Back.svg',
                  height: 44,
                  width: 44,
                ),
              ),
              Text(
                "Популярное",
                style: TextStyle(fontSize: 24, color: MyColors.textColor),
              ),
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritePage(),
                  ),
                ),
                icon: SvgPicture.asset(
                  'assets/unheart.svg',
                  height: 44,
                  width: 44,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Center(
          child: SizedBox(
            width: 335,
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
        ),
      ),
    );
  }
}
