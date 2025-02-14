import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test2/data/models/sneaker_model.dart';
import 'package:test2/domain/functions/functions.dart';
import 'package:test2/presentation/colors/color.dart';
import 'package:test2/presentation/widgets/bottom_nav_bar.dart';
import 'package:test2/presentation/widgets/sneaker_item.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              'assets/heart_page.svg',
              height: 44,
              width: 44,
            ),
          ),
        ],
        title: Text(
          "Избранное",
          style: TextStyle(fontSize: 24, color: MyColors.textColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Center(
          child: SizedBox(
            width: 335,
            child: FutureBuilder<List<SneakerModel>>(
              future: Functions.getFavoriteSneakers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No favorites found.'));
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
