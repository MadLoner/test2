import 'package:flutter/material.dart';
import 'package:test2/presentation/colors/color.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
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
                  'assets/sneaker2.png',
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 300,
                  child: Text(
                    'Начнем путешествие',
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
                    'Умная, великолепная и модная коллекция Изучите сейчас',
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
