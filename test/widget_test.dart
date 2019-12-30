import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toughest/showDetail.dart';

void main() {
  testWidgets('Checking showDetail page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
        MaterialApp(home: ShowDetail(quest: 'my question', ans: 'my answer')));
    List<String> expectedText = [
      'Question :',
      'my question',
      'Answer :',
      'my answer'
    ];
    // Gets the created widgets
    Iterable<Widget> listOfWidgets = tester.allWidgets;
    checkIfTextsCreatedCorrectly(listOfWidgets, expectedText);
    print('Found all texts\n');
    //Scrolling down to find the button.
    await tester.fling(find.text('my question'), Offset(0, -500),100);
     // Tap the share button.
    await tester.tap(find.byType(RaisedButton));
    // Rebuild the widget after the state has changed.
    await tester.pump();
    // Expect to find the button text.
    expect(find.text('Share answer with your friends'), findsOneWidget);
    print('Found and tap on the text\n');
  });
}

void checkIfTextsCreatedCorrectly(Iterable<Widget> listOfWidgets, List<String> expectedTexts) {
  var textWidgetPosition = 0;
  for (Widget widget in listOfWidgets) {
    if (widget is Text) {
      expect(widget.data, expectedTexts[textWidgetPosition]);
      textWidgetPosition++;
    }
    if (textWidgetPosition == 4) {
      break;
    }
  }
}
