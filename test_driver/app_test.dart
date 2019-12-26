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

    test('Tap on the item', () async {
      await delay(1000);
      await driver.waitFor(find.text('TOUGHEST'));
      await driver.tap(itemFinder);
    });
  });
}
