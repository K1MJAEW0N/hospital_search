import 'package:flutter/material.dart';
import 'sanjae_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SanjaeHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
