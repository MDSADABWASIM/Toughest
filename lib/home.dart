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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:carousel_pro/carousel_pro.dart';

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
  FirebaseMessaging messaging = FirebaseMessaging();

  ///Admob configuration.
  static final MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(
    testDevices: <String>[],
    birthday: DateTime.now(),
    childDirected: true,
    designedForFamilies: true,
    gender: MobileAdGender.unknown,
    keywords: <String>[
      'self-development',
      'T-shirts',
      'Shoes',
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
        "https://play.google.com/store/apps/details?id=tricky.questions");
  }

  _launchgmail() async {
    const url = 'mailto:indiancoder001@gmail.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    //notification configs.
    messaging.configure(
        onLaunch: (Map<String, dynamic> event) {},
        onMessage: (Map<String, dynamic> event) {},
        onResume: (Map<String, dynamic> event) {});
    messaging.requestNotificationPermissions(const IosNotificationSettings(
      sound: true,
      alert: true,
      badge: true,
    ));
    messaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {});
    messaging.getToken().then((msg) {});
    super.initState();
    //menucontroller for residemenu drawer.
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

  showAbout(BuildContext context) {
    final TextStyle linkStyle =
        Theme.of(context).textTheme.body2.copyWith(color: Colors.blue);
    final TextStyle bodyStyle =
        new TextStyle(fontSize: 15.0, color: Colors.black);

    return showAboutDialog(
        context: context,
        applicationIcon: Center(
          child: Image(
            height: 150.0,
            width: 200.0,
            fit: BoxFit.fitWidth,
            image: AssetImage("assets/images/author.png"),
          ),
        ),
        // applicationName: 'Toughest',
        // applicationVersion: '1.0',
        children: <Widget>[
          new Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: new RichText(
                  textAlign: TextAlign.start,
                  text: new TextSpan(children: <TextSpan>[
                    new TextSpan(
                        style: bodyStyle,
                        text: 'Hello,  We are Indian coder, we develop android and ios apps, ' +
                            " we are passionate about translating ideas " +
                            ' into user-friendly apps.' +
                            ' If you want to develop app for your business or anything feel free to contact us.'
                            ' We can build awesome apps in lowest price range.'
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

  ///Lis-t of interview questions.
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

final myCraousal=Carousel(
               
                dotSize: 5.0,
                dotIncreaseSize: 2.0,
                 borderRadius: true,
                 radius: Radius.circular(10.0),
                 animationCurve: Curves.easeInOut,
                 animationDuration: Duration(seconds: 4),
                images: [
                  AssetImage('assets/images/card1.png'),
                  AssetImage('assets/images/card3.png'),
                   AssetImage('assets/images/card4.png'),
                    AssetImage('assets/images/card2.png'),
                ],
              );
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    //to use reside menu library we have to return a residemenu scafford.
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
            backgroundImage: new AssetImage('assets/images/icon.jpg'),
            radius: 30.0,
          ),
        ),
        children: <Widget>[
          ///I have to make these drawer list widgets manually cause it is containing different methods.
          new Material(
            color: Colors.transparent,
            child: new InkWell(
              child: ResideMenuItem(
                title: 'Share the App',
                icon: const Icon(Icons.share, color: Colors.black),
              ),
              onTap: () => _sharer(),
            ),
          ),
          new Material(
            color: Colors.transparent,
            child: new InkWell(
              child: ResideMenuItem(
                title: 'Suggestions',
                icon: const Icon(Icons.bug_report, color: Colors.black),
              ),
              onTap: () => _launchgmail(),
            ),
          ),
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
                  size: 20.0,
                ),
                onPressed: () => showAbout(context))
          ],
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 5.0),
              height:height/2.5 ,
               child: myCraousal,
            ),
            getListItems(Color(0xFFF1B136), Icons.person, 'Behavioural Based'),
            getListItems(Color(0xFF885F7F), Icons.wc, 'Communications Based'),
            getListItems(Color(0xFF13B0A5), Icons.call_split, 'Opinion Based'),
            getListItems(
                Color(0xFFD0C490), Icons.assessment, 'Performance Based'),
            getListItems(Color(0xFFEF6363), Icons.help_outline, 'Brainteasers'),
          ],
        ),
        persistentFooterButtons: <Widget>[
          Container(
            height: 33.0,
          )
        ],
      ),
    );
  }
}
