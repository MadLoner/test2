import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test2/data/models/sneaker_model.dart';
import 'package:test2/domain/functions/functions.dart';
import 'package:test2/presentation/colors/color.dart';
import 'package:test2/presentation/widgets/sneaker_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(
            'assets/Back.svg',
            height: 44,
            width: 44,
          ),
        ),
        title: Text(
          "Поиск",
          style: TextStyle(fontSize: 16, color: MyColors.textColor),
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
                        elevation: 2,
                        shadowColor: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                        child: TextField(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchPage(),
                            ),
                          ),
                          readOnly: true,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(left: 26, right: 17),
                              child: Image.asset(
                                'assets/Icon.png',
                                width: 24,
                                height: 24,
                              ),
                            ),
                            suffix: Row(
                              children: [
                                SvgPicture.asset('assets/vertical.svg'),
                                SizedBox(
                                  width: 12,
                                ),
                                SvgPicture.asset('assets/microfon.svg'),
                              ],
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
                                desc: sneakers[index].description,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
