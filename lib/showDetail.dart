import 'dart:async';
import 'package:mark922_flutter_lottie/mark922_flutter_lottie.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'dart:math';
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
  ];

  @override
  ShowDetailState createState() {
    return ShowDetailState();
  }
}

class ShowDetailState extends State<ShowDetail> {
  LottieController controller2;
  StreamController<double> newProgressStream;

  @override
  void initState() {
    super.initState();
    newProgressStream = StreamController<double>();
  }

  @override
  void dispose() {
    newProgressStream.close();
    super.dispose();
  }

  share(String question, String answer) {
    Share.share("Q:" +
        question +
        "\n\n" +
        "A:" +
        answer +
        "\n\nDownload the app for more amazing Q/A\n " +
        "https://play.google.com/store/apps/details?id=tricky.questions");
  }


  ///add details in card.
  Widget cardDetail(String text) {
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
              borderRadius: BorderRadius.circular(9.0),
              color: ShowDetail._colors[ShowDetail.randomNumber.nextInt(100) %
                  ShowDetail._colors.length],
            ),
            margin: EdgeInsets.all(8.0),
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
        backgroundColor: Color(0xFFC67A7D),
        title: Text('Answer'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
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
            height: 10.0,
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
          ]),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            shape: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(5.0),
                borderSide: BorderSide.none),
            splashColor: const Color(0xff382151),
            elevation: 10.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Share answer with your friends",
                  style: Style.regularTextStyle,
                ),
                SizedBox(width: 5,),
                Icon(Icons.share),
              ],
            ),
            color: Color(0xFF56cfdf),
            onPressed: () => share(widget.quest, widget.ans),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  void onViewCreatedFile(LottieController controller) {
    this.controller2 = controller;
    newProgressStream.stream.listen((double progress) {
      this.controller2.setAnimationProgress(progress);
    });
  }
}
