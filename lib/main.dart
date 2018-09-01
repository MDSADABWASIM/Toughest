import 'package:flutter/material.dart';
import 'package:toughest/home.dart';
import 'package:fluttie/fluttie.dart';
// TODO: Deploy the app.
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(fontFamily: 'Josefin Sans'),
      home: Home(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    {
 
  FluttieAnimationController controller;
  bool ready;

  @override
  void initState() {
    super.initState();
   prepareAnimation();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  prepareAnimation() async {
    // Checks if the platform we're running on is supported by the animation plugin
    bool canBeUsed = await Fluttie.isAvailable();
    if (!canBeUsed) {
      print("Animations are not supported on this platform");
      return;
    }

    var instance = new Fluttie();
    var emojiComposition = await instance.loadAnimationFromAsset(
      "assets/confetti.json", //Replace this string with your actual file
    );
    controller = await instance.prepareAnimation(emojiComposition,
        duration: const Duration(seconds: 4),
        repeatCount: const RepeatCount.nTimes(2),
        repeatMode: RepeatMode.START_OVER);
    if (mounted) {
      setState(() {
        ready = true; // The animations have been loaded, we're ready
        controller.start(); //start our looped emoji animation
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ready ? FluttieAnimation(controller,size: Fluttie.kDefaultSize) : Text("loading...")
    ));
  }
}
