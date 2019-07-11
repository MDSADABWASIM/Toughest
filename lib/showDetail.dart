import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'dart:math';
// import 'package:fluttie/fluttie.dart';
import 'package:toughest/textStyle.dart';

class ShowDetail extends StatefulWidget {
  final String quest, ans;
  static var randomNumber = Random();
  ShowDetail({this.quest, this.ans});

  static final List<Color> _colors = [
    Colors.red,
    Colors.teal,
    Colors.orange,
    Colors.green,
    Colors.pink,
    Colors.purple,
    Colors.blue,
    Color(0xFFF1B136),
    Color(0xFF885F7F),
    Color(0xFF13B0A5),
    Color(0xFFD0C490),
    Color(0xFFEF6363),
  ];

  @override
  ShowDetailState createState() {
    return new ShowDetailState();
  }
}

class ShowDetailState extends State<ShowDetail> {
//   FluttieAnimationController controller;
//   bool ready = false;

//   @override
//   void initState() {
//     super.initState();
//     prepareAnimation();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

// ///prepare for lottie animation.
//   prepareAnimation() async {
//     // Checks if the platform we're running on is supported by the animation plugin
//     bool canBeUsed = await Fluttie.isAvailable();
//     if (!canBeUsed) {
//       print("Animations are not supported on this platform");
//       return;
//     }

//     var instance = new Fluttie();
//     var emojiComposition = await instance.loadAnimationFromAsset(
//       "assets/confetti.json", //Replace this string with your actual file
//     );
//     controller = await instance.prepareAnimation(emojiComposition,
//         duration: const Duration(seconds: 2),
//         repeatCount: const RepeatCount.nTimes(1),
//         repeatMode: RepeatMode.START_OVER);
//     if (mounted) {
//       setState(() {
//         ready = true; // The animations have been loaded, we're ready
//         controller.start(); //start our looped emoji animation
//       });
//     }
//   }

  share(String question, String answer) {
    Share.share("Q:" +
        question +
        "\n\n" +
        "A:" +
        answer +
        "\n\nDownload the app for more amazing Q/A\n " +
        "https://play.google.com/store/apps/details?id=tricky.questions");
  }

  Widget _card = new Container(
    // child: Text(text, style: TextStyle(fontSize: 15.0)),
    height: 170.0,
    margin: new EdgeInsets.all(8.0),
    decoration: new BoxDecoration(
      color: ShowDetail._colors[
          ShowDetail.randomNumber.nextInt(100) % ShowDetail._colors.length],
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black12,
          blurRadius: 10.0,
          offset: new Offset(0.0, 10.0),
        ),
      ],
    ),
  );

///add details in card.
  Widget cardDetail(String text) {
    return Stack(
      children: <Widget>[
        _card,
        Container(
            margin: EdgeInsets.all(20.0),
            child: Text(
              text,
              style: Style.commonTextStyle,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        backgroundColor: new Color(0xFFC67A7D),
        title: Text('Answer'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              "Question :",
              style: Style.headerTextStyle,
            ),
          ),
          cardDetail(widget.quest),
          SizedBox(
            height: 30.0,
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: Text(
              'Answer :',
              style: Style.headerTextStyle,
            ),
          ),
          Stack(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.ans,
                style: Style.regularTextStyle,
              ),
            ),
            // ready
            //     ? Center(
            //         child: FluttieAnimation(controller,
            //             size: Fluttie.kDefaultSize))
            //     : Container(
            //         height: 1.0,
            //       ),
          ]),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            shape: BeveledRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
            splashColor: const Color(0xff382151),
            elevation: 20.0,
            child: Text("Share answer with your friends",style: Style.regularTextStyle,),
            color: Color(0xFF56cfdf),
            onPressed: () => share(widget.quest, widget.ans),
          ),
          SizedBox(height: 20.0),
      ],
      ),
     );
  }
}
