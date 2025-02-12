import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test2/presentation/colors/color.dart';

class SneakerItem extends StatelessWidget {
  const SneakerItem({
    super.key,
    required this.fullname,
    required this.price,
  });

  final String fullname;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 30),
      padding: EdgeInsets.only(left: 10, top: 10),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/sneaker_item_image.png',
                width: 130,
                height: 80,
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
                  Text(fullname),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('₽ $price'),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 45),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(14)),
                        child: Image.asset(
                          'assets/add_to_cart.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
