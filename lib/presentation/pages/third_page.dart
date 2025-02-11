import 'package:flutter/material.dart';
import 'package:test2/presentation/colors/color.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          height: MediaQuery.of(context).size.height - 300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/sneaker3.png',
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 300,
                  child: Text(
                    'У вас есть сила, чтобы',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontFamily: 'Arial',
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Text(
                    'В вашей комнате много красивых и привлекательных растений',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: MyColors.subtextLightColor,
                      fontSize: 16,
                      fontFamily: 'Arial',
                    ),
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
