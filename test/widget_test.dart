import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toughest/showDetail.dart';

void main() {
  testWidgets('Checking showDetail page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: ShowDetail(quest:'my question',ans: 'my answer')));
      List<String> expectedText=['Question :','my question','Answer :','my answer'];
      // Gets the created widgets
      Iterable<Widget> listOfWidgets = tester.allWidgets;
      checkIfTextsCreatedCorrectly(listOfWidgets,expectedText);
  });

}

  void checkIfTextsCreatedCorrectly(Iterable<Widget> listOfWidgets, List<String> expectedTexts) {
  var textWidgetPosition = 0;
  for(Widget widget in listOfWidgets) {
    if(widget is Text) {
      expect(widget.data, expectedTexts[textWidgetPosition]);
      textWidgetPosition++;
    }
    if(textWidgetPosition==4){
      break;
    }
  }
}