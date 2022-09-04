import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:toughest/ui/detail.dart';
import 'package:toughest/commons/textStyle.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  var data;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SideMenu(
      key: _sideMenuKey,
      background: Colors.purple.shade300,
      menu: buildMenu(),
      type: SideMenuType.shrinkNSlide,
      child: new Scaffold(
        appBar: new AppBar(
          elevation: 10.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: new GestureDetector(
            child: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onTap: () {
              final _state = _sideMenuKey.currentState!;
              if (_state.isOpened) {
                _state.closeSideMenu();
              } else {
                _state.openSideMenu();
              }
            },
          ),
          title: new Text(
            'TOUGHEST',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              key: Key('banner'),
              padding: EdgeInsets.only(bottom: 5.0),
              height: height / 2.5,
              child: myCarousel,
            ),
            getListItems(Color(0xFFF1B136), Icons.person, 'Behavioural Based'),
            getListItems(Color(0xFF885F7F), Icons.wc, 'Communications Based'),
            getListItems(Color(0xFF13B0A5), Icons.call_split, 'Opinion Based'),
            getListItems(
                Color(0xFFD0C490), Icons.assessment, 'Performance Based'),
            getListItems(Color(0xFFEF6363), Icons.help_outline, 'Brainteasers'),
          ],
        ),
      ),
    );
  }

  ///Lis-t of interview questions.
  Widget getListItems(Color color, IconData icon, String title) {
    return GestureDetector(
        key: title == 'Behavioural Based' ? Key('item') : null,
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: color),
          height: 300.0,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 100.0,
                color: Colors.white,
              ),
              Text(
                title,
                style: Style.headerstyle,
              )
            ],
          )),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Detail(
                    title: title,
                  )));
        });
  }

  ///creating a carousel using carousel pro library.
  final myCarousel = CarouselSlider(
    options: CarouselOptions(
      height: 400.0,
      autoPlay: true,
      autoPlayCurve: Curves.easeInOut,
      autoPlayAnimationDuration: Duration(seconds: 2),
    ),
    items: [
      Image.asset('assets/images/card1.png'),
      Image.asset('assets/images/card3.png'),
      Image.asset('assets/images/card4.png'),
      Image.asset('assets/images/card2.png'),
    ],
  );

  buildMenu() {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text('Share the App', style: Style.drawerTextStyle),
              leading: const Icon(Icons.share, color: Colors.white),
              onTap: () => _sharer(),
            ),
            ListTile(
              title: Text('Suggestions', style: Style.drawerTextStyle),
              leading: const Icon(Icons.bug_report, color: Colors.white),
              onTap: () => _launchgmail(),
            ),
          ],
        ));
  }

  _sharer() {
    Share.share("Skills 101/TOUGHEST - Test your knowledge.\n" +
        "The app that will make you an amazing candidate for any job.\n"
            "Are you ready?\n"
            "Download it now\n"
            "https://play.google.com/store/apps/details?id=tricky.questions");
  }

  _launchgmail() async {
    final Uri _url = Uri.parse(
        'mailto:indiancoder001@gmail.com?subject=Feedback&body=Feedback for Toughest');
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
