import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toughest/detail.dart';
import 'package:toughest/home.dart';

void main() {
  Home home;
  VoidCallback call;
  setUp(() {
    home = Home();
  });

  group("Check Home page methods returns the widget", () {
    test("create list item", () {
      Widget wid =home.createState().getListItems(Colors.blue, Icons.add, 'Add item');
      expect(wid, isNot(null));
    });

    test("create homePage item", () {
      Widget item = home.createState().buildItem('maths', call);
      expect(item, isNot(null));
    });
  });

  group("Check detail page creation", () {
    test("Creating detail page", () {
      Detail detail = Detail(title: 'Communications Based');
      String text = detail.title;
      Widget items = detail.buildListItems();
      expect(text, isA<String>());
      expect(text, equals('Communications Based'));
      expect(items, isNot(null));
    });
  });
}
