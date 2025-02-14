import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test2/domain/functions/functions.dart';
import 'package:test2/presentation/colors/color.dart';

class SneakerItem extends StatefulWidget {
  const SneakerItem(
      {super.key,
      required this.uuid,
      required this.fullname,
      required this.price,
      required this.isPopular,
      required this.isBestSeller});

  final String fullname;
  final String price;
  final String uuid;
  final bool isPopular;
  final bool isBestSeller;

  @override
  State<SneakerItem> createState() => _SneakerItemState();
}

bool isFav = false;

class _SneakerItemState extends State<SneakerItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: !widget.isPopular ? EdgeInsets.only(right: 30) : null,
      padding: !widget.isPopular
          ? EdgeInsets.only(left: 10, top: 10, right: 0)
          : EdgeInsets.only(left: 10, top: 10),
      decoration: BoxDecoration(
        color: MyColors.blockColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: Functions.getSneakerImage(widget.uuid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(
                      child: Text('No image available'),
                    );
                  } else {
                    Uint8List image = snapshot.data!;
                    return Image.memory(
                      image,
                      height: 80,
                      width: !widget.isPopular ? 140 : null,
                    );
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  widget.isBestSeller
                      ? Text(
                          'Best Seller',
                          style: TextStyle(
                            fontSize: 12,
                            color: MyColors.accentColor,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    widget.fullname,
                    style: TextStyle(
                      fontSize: 16,
                      color: MyColors.textColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '₽ ${widget.price}',
                    style: TextStyle(
                      fontSize: 14,
                      color: MyColors.textColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      log('clicked');
                    },
                    child: Padding(
                      padding: !widget.isPopular
                          ? EdgeInsets.only(left: 60)
                          : EdgeInsets.zero,
                      child: GestureDetector(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(14)),
                          child: Image.asset(
                            'assets/add_to_cart.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 500),
                () => Functions.checkIfSneakerFavorite(widget.uuid)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  width: 10,
                  height: 10,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                if (snapshot.data!) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        Functions.removeSneakerFavorite(widget.uuid);
                      });
                    },
                    child: SvgPicture.asset(
                      'assets/heart_item.svg',
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        Functions.setSneakerFavorite(widget.uuid);
                      });
                    },
                    child: SvgPicture.asset(
                      'assets/unheart.svg',
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
