import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:toughest/ui/showDetail.dart';
import 'package:toughest/widgets/my_elevated_button.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

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
    await tester.fling(find.text('my question'), Offset(0, -500), 100);
    // Tap the share button.
    await tester.tap(find.byType(MyElevatedButton));
    // Rebuild the widget after the state has changed.
    await tester.pump();
    // Expect to find the button text.
    expect(find.text('Share answer with your friends'), findsOneWidget);
    print('Found and tapped on the text\n');
  });
}

void checkIfTextsCreatedCorrectly(
    Iterable<Widget> listOfWidgets, List<String> expectedTexts) {
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
