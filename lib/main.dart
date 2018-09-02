import 'package:flutter/material.dart';
import 'package:toughest/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Josefin Sans'),
      home: Home(),
    );
  }
}

