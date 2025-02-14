import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test2/domain/functions/functions.dart';
import 'package:test2/domain/services/riverpod/descprovider.dart';
import 'package:test2/presentation/colors/color.dart';

class DetailsPage extends ConsumerStatefulWidget {
  const DetailsPage({super.key, required this.id, required this.desc});

  final String id;
  final String desc;
  @override
  ConsumerState<DetailsPage> createState() => _DetailsPageState();
}

String idSneaker = '';

class _DetailsPageState extends ConsumerState<DetailsPage> {
  @override
  void initState() {
    idSneaker = widget.id;
    log(idSneaker);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final revealed = ref.watch(descProvider);
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
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {},
              icon: Stack(
                alignment: Alignment.topRight,
                children: [
                  SvgPicture.asset('assets/notification_dot.svg'),
                  SvgPicture.asset('assets/cart_icon.svg'),
                ],
              ),
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(
            'assets/Back.svg',
            height: 44,
            width: 44,
          ),
        ),
        title: Text(
          "Sneaker Shop",
          style: TextStyle(fontSize: 16, color: MyColors.textColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: FutureBuilder(
          future: Functions.getSneaker(idSneaker),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No sneaker found.'));
            } else {
              final sneaker = snapshot.data!;
              return Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 260,
                        child: Text(
                          sneaker.fullname,
                          style: TextStyle(fontSize: 26),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 260,
                        child: FutureBuilder(
                          future: Functions.getCategoryName(sneaker.category),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData) {
                              return Center(child: Text('No category found.'));
                            } else {
                              return Text(
                                snapshot.data!,
                                style: TextStyle(
                                    fontSize: 16, color: MyColors.hintColor),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 260,
                        child: Text(
                          '₽${sneaker.price}',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/sneaker_placeholder.png',
                      ),
                      FutureBuilder(
                        future: Functions.getSneakerImage(idSneaker),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data == null) {
                            return Center(
                              child: Text('No image available'),
                            );
                          } else {
                            Uint8List image = snapshot.data!;
                            return Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 100, right: 20),
                              child: Image.memory(
                                image,
                                height: 130,
                                width: 260,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 56,
                    child: FutureBuilder(
                      future: Functions.getSneakersImage(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return Center(
                            child: Text('No image available'),
                          );
                        } else {
                          List<Map<String, dynamic>> images = snapshot.data!;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              final imageData = images[index];
                              final image = imageData['image'] as Uint8List;
                              final imageId = imageData['id'] as String;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    idSneaker = imageId;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: MyColors.blockColor,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: imageId == idSneaker
                                          ? MyColors.accentColor
                                          : Colors.transparent,
                                    ),
                                  ),
                                  margin: EdgeInsets.only(right: 20),
                                  padding: EdgeInsets.only(
                                      top: 10, bottom: 10, right: 5, left: 5),
                                  child: Image.memory(
                                    image,
                                    height: 56,
                                    width: 56,
                                    fit: BoxFit.contain,
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
                    height: 25,
                  ),
                  SizedBox(
                    height: 120,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            widget.desc,
                            maxLines: revealed ? null : 3,
                            style: TextStyle(
                              fontSize: 14,
                              color: MyColors.hintColor,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  ref.read(descProvider.notifier).state =
                                      !revealed;
                                },
                                child: Text(
                                  revealed ? "Скрыть" : "Подробнее",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: MyColors.accentColor,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FutureBuilder(
                        future: Functions.checkIfSneakerFavorite(idSneaker),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data == null) {
                            return Center(
                              child: Text('No image available'),
                            );
                          } else {
                            return snapshot.data!
                                ? GestureDetector(
                                    onTap: () {
                                      setState(
                                        () {
                                          Functions.removeSneakerFavorite(
                                              idSneaker);
                                        },
                                      );
                                    },
                                    child: SvgPicture.asset(
                                      'assets/heart_item.svg',
                                      height: 52,
                                      width: 52,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(
                                        () {
                                          Functions.setSneakerFavorite(
                                              idSneaker);
                                        },
                                      );
                                    },
                                    child: SvgPicture.asset(
                                      'assets/unheart.svg',
                                      height: 52,
                                      width: 52,
                                    ),
                                  );
                          }
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          width: 265,
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: MyColors.accentColor,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(children: [
                                SizedBox(
                                  width: 12,
                                ),
                                SvgPicture.asset('assets/cart_item.svg'),
                              ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'В Корзину',
                                    style: TextStyle(
                                      fontFamily: 'New Peninim MT',
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
