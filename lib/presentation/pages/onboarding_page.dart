import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test2/presentation/colors/color.dart';
import 'package:test2/presentation/pages/first_page.dart';
import 'package:test2/presentation/pages/login.dart';
import 'package:test2/presentation/pages/second_page.dart';
import 'package:test2/presentation/pages/third_page.dart';
import 'package:test2/presentation/widgets/mybutton.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

PageController controller = PageController();
int _index = 0;

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            MyColors.accentColor,
            MyColors.disableColor,
          ],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 270,
                child: PageView(
                  controller: controller,
                  onPageChanged: (value) {
                    setState(() {
                      _index = value;
                    });
                  },
                  children: [
                    FirstPage(),
                    SecondPage(),
                    ThirdPage(),
                  ],
                ),
              ),
              SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: WormEffect(
                    dotWidth: 50,
                    dotHeight: 5,
                    activeDotColor: MyColors.backgroundColor,
                    dotColor: MyColors.disableColor),
              ),
              SizedBox(
                height: 100,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: MyButton(
                    titleColor: MyColors.textColor,
                    onTap: () {
                      if (_index < 2) {
                        controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }
                    },
                    title: _index == 0 ? 'Начать' : 'Далее',
                    color: MyColors.backgroundColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
