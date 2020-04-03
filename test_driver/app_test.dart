import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  // RUN THIS INTEGRATION TEST USING flutter drive --target=test_driver/app.dart

  group('test home page', () {
    final itemFinder = find.byValueKey('item');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      // This line enables the extension
      driver = await FlutterDriver.connect();
    });

    //close the driver after finishing the tests.
    tearDownAll(() {
      if (driver != null) {
        driver.close();
      }
    });

    test('check flutter driver health', () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });

    Future<void> delay([int milliseconds = 250]) async {
      await Future<void>.delayed(Duration(milliseconds: milliseconds));
    }

    test('Drag the banner', () async {
      await delay(1000);
      await driver.scroll(
          find.byValueKey('banner'), -500, 0, Duration(milliseconds: 500));
      print('banner scrolled successfully');
    });

    test('Scroll the items', () async {
      await delay(1000);
      final timeline = await driver.traceAction(() async {
        await driver.scroll(itemFinder, 0, -500, Duration(milliseconds: 1000));
      });
      // Convert the Timeline into a TimelineSummary that's easier to
      // read and understand.
      final summary = TimelineSummary.summarize(timeline);

      // Then, save the summary to disk.
      summary.writeSummaryToFile('scrolling_summary', pretty: true);

      print('item scrolled successfully');
    });

    test('Tap on the item', () async {
      await delay(1000);
      await driver.waitFor(find.text('TOUGHEST'));
    });
  });
}
