import 'package:flutter/material.dart';
import 'package:residemenu/residemenu.dart';
import 'package:toughest/detail.dart';
import 'package:share/share.dart';
import 'package:toughest/textStyle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:flutter/gestures.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'appid.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
  }
}

class _LinkTextSpan extends TextSpan {
  _LinkTextSpan({TextStyle style, String url, String text})
      : super(
            style: style,
            text: text ?? url,
            recognizer: new TapGestureRecognizer()
              ..onTap = () {
                urlLauncher.launch(url);
              });
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  MenuController _menuController;
  BannerAd bannerAd;
  var data;

///Admob configuration.
static final MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
    testDevices: <String>[],
    birthday: DateTime.now(),
    childDirected: true,
    designedForFamilies: true,
    gender: MobileAdGender.unknown,
    keywords: <String>[
      'self-development',
      'udemy',
      'shopping',
      'shopping offers',
      'low price ',
      'cheapest shopping'
    ],
  );

  BannerAd createBannerAd() {
    return new BannerAd(
        adUnitId: Appid.ADMOB_AD_ID,
        targetingInfo: targetingInfo,
        size: AdSize.smartBanner,
        listener: (MobileAdEvent event) {});
  }

  /// to build a reside menu drawer build by library
  Widget buildItem(String msg, VoidCallback method) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        child: ResideMenuItem(
          title: msg,
          icon: const Icon(Icons.home, color: Colors.grey),
          right: const Icon(Icons.arrow_forward, color: Colors.grey),
        ),
        onTap: () => method,
      ),
    );
  }

  _sharer() {
    Share.share(" TOUGHEST - Test your knowledge.\n" +
        "The app that will make you an amazing candidate for any job.\n"
        "Are you ready?\n"
        "Download it now\n"
        "https://play.google.com/store/apps/details?id=interview.questions");
  }

  _launchgmail() async {
    const url = 'mailto:indiancoder001@gmail.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  AboutListTile _buildAboutListTile(BuildContext context) {
    final TextStyle bodyStyle =
        new TextStyle(fontSize: 15.0, color: Colors.black);
    final TextStyle linkStyle =
        Theme.of(context).textTheme.body2.copyWith(color: Colors.blue);

    return new AboutListTile(
        icon: new Icon(
          Icons.person,
          color: Colors.white,
        ),
        applicationIcon: Center(
          child: new Image(
            height: 130.0,
            image: new AssetImage("lib/asset/image/me.jpg"),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: new Text(
          "About Us",
        ),
        // TODO
        aboutBoxChildren: <Widget>[
          new Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: new RichText(
                  textAlign: TextAlign.start,
                  text: new TextSpan(children: <TextSpan>[
                    new TextSpan(
                        style: bodyStyle,
                        text:
                            'Hello,  I am Sadab from the Indian coder, an android and ios app developer, ' +
                                " I am passionate about translating ideas " +
                                ' into user-friendly apps.' +
                                "\n\n"),
                    new TextSpan(
                      style: bodyStyle,
                      text: 'for Business Queries:' + "\n\n",
                    ),
                    new _LinkTextSpan(
                      style: linkStyle,
                      text: 'Send a Whatsapp message' + "\n\n",
                      url: 'https://api.whatsapp.com/send?phone=+918210296495',
                    ),
                    new _LinkTextSpan(
                      style: linkStyle,
                      text: 'Send an E-mail' + "\n\n",
                      url: 'mailto:indiancoder001@gmail.com',
                    ),
                    new _LinkTextSpan(
                      style: linkStyle,
                      text: 'Send a facebook message' + "\n\n",
                      url: 'https://www.facebook.com/sadab.wasim.3',
                    ),
                    new _LinkTextSpan(
                        style: linkStyle,
                        text: 'Github repos' + "\n\n",
                        url: 'https://github.com/MDSADABWASIM'),
                  ]))),
        ]);
  }

  @override
  void initState() {
    super.initState();
    _menuController = new MenuController(vsync: this);
     FirebaseAdMob.instance.initialize(appId: Appid.ADMOB_APP_ID);
    bannerAd = createBannerAd()
      ..load()
      ..show();
  }
  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }
  Widget getListItems(Color color, IconData icon, String title) {
    return GestureDetector(
        child: Container(
          color: color,
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
        onTap: () async {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Detail(
                    title: title,
                  )));
        });
  }

  @override
  Widget build(BuildContext context) {
    return new ResideMenu.scafford(
      direction: ScrollDirection.LEFT,
      decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover)),
      controller: _menuController,
      leftScaffold: new MenuScaffold(
        header: new ConstrainedBox(
          constraints: new BoxConstraints(maxHeight: 80.0, maxWidth: 100.0),
          child: new CircleAvatar(
            backgroundImage: new AssetImage('assets/images/author.png'),
            radius: 50.0,
          ),
        ),
        children: <Widget>[
          ///I have to make these widgets manually containing different methods.
          new Material(
            color: Colors.transparent,
            child: new InkWell(
              child: ResideMenuItem(
                title: 'Share the App',
                icon: const Icon(Icons.share, color: Colors.white),
              ),
              onTap: () => _sharer(),
            ),
          ),
          new Material(
            color: Colors.transparent,
            child: new InkWell(
              child: ResideMenuItem(
                title: 'Suggestions / Issues',
                icon: const Icon(Icons.bug_report, color: Colors.white),
              ),
              onTap: () => _launchgmail(),
            ),
          ),
    // buildItem('Feedback', _sharer())
        ],
      ),
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
              _menuController.openMenu(true);
            },
          ),
          title: new Text(
            'TOUGHEST',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.person_outline,
                color: Colors.black,
                size: 15.0,
              ),
              onPressed: ()=> _buildAboutListTile(context),
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            getListItems(Color(0xFFF1B136), Icons.person, 'Behavioural Based'),
            getListItems(Color(0xFF885F7F), Icons.wc, 'Communications Based'),
            getListItems(Color(0xFF13B0A5), Icons.call_split, 'Opinion Based'),
            getListItems(Color(0xFFD0C490), Icons.assessment, 'Performance Based'),
            getListItems(Color(0xFFEF6363), Icons.help_outline, 'Brainteasers'),
          ],
        ),
         persistentFooterButtons: <Widget>[Container(height: 30.0,)],
      ),
    );
  }
}
