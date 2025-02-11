import 'package:flutter/material.dart';
import 'package:test2/presentation/pages/first_page.dart';
import 'package:test2/presentation/pages/home_page.dart';
import 'package:test2/presentation/pages/login.dart';
import 'package:test2/presentation/pages/onboarding_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
