import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:share_plus/share_plus.dart';
import 'dart:convert';
import 'package:toughest/commons/textstyle.dart';
import 'package:toughest/models/items.dart';
import 'package:toughest/ui/showdetail.dart';

class Detail extends StatelessWidget {
  final dynamic data;
  final dynamic title;
  const Detail({
    super.key,
    this.data,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 20.0,
          backgroundColor: Color(0xFFC67A7D),
          title: Text(
            'Questions',
            style: TextStyle(fontWeight: FontWeight.w500),
          )),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFFC67A7D),
                  Color(0xFF5D3068),
                ],
                stops: [0.0, 0.9],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
              )),
              child: buildListItems(),
            ),
          ),
        ],
      ),
    );
  }

  //our list of questions type.
  List list() {
    String type;
    if (title == 'Behavioural Based') {
      type = "Behaviour";
    } else if (title == 'Communications Based') {
      type = "Communication";
    } else if (title == 'Opinion Based') {
      type = "Opinion";
    } else if (title == 'Performance Based') {
      type = "Performance";
    } else {
      type = "Brainteasures";
    }
    List list;
    list = data[type] as List;
    // print(list);
    List<Item> typeList = list.map((i) => Item.fromJson(i)).toList();
    return typeList;
  }

  share(String title) {
    Share.share("Answer this question\n\n$title");
  }

  ///Takes the local json file,
  ///because that contains, Q/A data.
  _retrieveLocalData() async {
    return await rootBundle.loadString('assets/local.json');
  }

  ///take the asset and decode json file.
  Future<List<Item>> loadData() async {
    late ItemList itemList;
    try {
      String type;

      if (title == 'Behavioural Based') {
        type = "Behaviour";
      } else if (title == 'Communications Based') {
        type = "Communication";
      } else if (title == 'Opinion Based') {
        type = "Opinion";
      } else if (title == 'Performance Based') {
        type = "Performance";
      } else {
        type = "Brainteasures";
      }
      String jsonString = await _retrieveLocalData();
      final jsonResponse = json.decode(jsonString);
      final jsonData = jsonResponse[type];
      itemList = ItemList.fromJson(jsonData);
    } catch (e) {
      debugPrint(e.toString());
    }
    return itemList.list;
  }

  ///List of questions uses futurBuilder.
  Widget buildListItems() {
    return FutureBuilder(
      future: loadData(),
      builder: (context, AsyncSnapshot<List<Item>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, i) {
            String quest, ans;
            quest = snapshot.data![i].question;
            ans = snapshot.data![i].answer;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      quest,
                      style: Style.commonTextStyle,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.share, color: Colors.white),
                      iconSize: 18.0,
                      onPressed: () => share(quest),
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            ShowDetail(quest: quest, ans: ans),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Divider(
                        color: Colors.white,
                      )),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
