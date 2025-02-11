import 'package:flutter/material.dart';
import 'package:test2/presentation/colors/color.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
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
                SizedBox(
                  width: 250,
                  child: Text(
                    'ДОБРО ПОЖАЛОВАТЬ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'Arial',
                    ),
                  ),
                ),
                Image.asset(
                  'assets/sneaker1.png',
                  fit: BoxFit.cover,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
