import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:toughest/home.dart';
import 'package:toughest/showDetail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('HomePage navigation tests', () {
    NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    Future<Null> _buildMainPage(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Home(),

        /// This mocked observer will now receive all navigation events
        /// that happen in our app.
        navigatorObservers: [mockObserver],
      ));

      /// The tester.pumpWidget() call above just built our app widget
      /// and triggered the pushObserver method on the mockObserver once.
      verify(mockObserver.didPush(any, any));
    }

    Future<Null> _navigateToDetailsPage(WidgetTester tester) async {
      /// Tap the button which should navigate to the details page.
      /// By calling tester.pump(), we ensure that all animations
      /// have completed before we continue further.
      await tester.tap(find.byKey(Key('item')));
      await tester.pump();
    }

    testWidgets('testing navigation from home page to Detail page',
        (WidgetTester tester) async {
      await tester.runAsync(() async {
        await _buildMainPage(tester);
        await _navigateToDetailsPage(tester);
      });

      verify(mockObserver.didPush(any, any));
    });
  });

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
    await tester.tap(find.byType(RaisedButton));
    // Rebuild the widget after the state has changed.
    await tester.pump();
    // Expect to find the button text.
    expect(find.text('Share answer with your friends'), findsOneWidget);
    print('Found and tap on the text\n');
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
