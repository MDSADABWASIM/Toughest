import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:share/share.dart';
import 'package:toughest/textStyle.dart';
import 'package:toughest/showDetail.dart';

class Detail extends StatelessWidget {
  final data, title;
  Detail({this.data, this.title});

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
    var list;
    list = data[type] as List;
    print(list);
    List<Item> typeList = list.map((i) => Item.fromJson(i)).toList();
    return typeList;
  }

  share(String title) {
    Share.share("Answer this question\n\n" + title);
  }

///Takes the local json file which is not included in this repository,
///because that contains, Q/A data.
  _retrieveLocalData() async {
    return await rootBundle.loadString('assets/local.json');
  }

  ///take the asset and decode json file.
  loadData() async {
    try {
      String type;
      ItemList itemList;
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
      return itemList.list;
    } catch (e) {
      print(e);
    }
  }

  ///List of questions uses futurBuilder.
  Widget buildListItems() {
    return FutureBuilder(
      future: loadData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: new CircularProgressIndicator());
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, i) {
            String quest, ans;
            quest = snapshot.data[i].question;
            ans = snapshot.data[i].answer;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(
                  quest,
                  style: Style.commonTextStyle,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.share, color: Color(0xFF56cfdf)),
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
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          elevation: 20.0,
          backgroundColor: new Color(0xFFC67A7D),
          title: Text('Questions')),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Flexible(
            child: Container(
              child: buildListItems(),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: <Color>[
                  new Color(0xFFC67A7D),
                  new Color(0xFF5D3068),
                ],
                stops: [0.0, 0.9],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
              )),
            ),
          ),
        ],
      ),
      
    );
  }
}

//these two classes are here to help in decoding json data.
class ItemList {
  List<Item> list;
  ItemList({this.list});

  factory ItemList.fromJson(List<dynamic> parsedJson) {
    var lists = parsedJson;
    List<Item> itemLists = lists.map((f) => Item.fromJson(f)).toList();
    return ItemList(list: itemLists);
  }
}

class Item {
  String question, answer;
  Item({this.question, this.answer});

  factory Item.fromJson(Map<String, dynamic> parsedJson) {
    return Item(question: parsedJson['Q'], answer: parsedJson['A']);
  }
}
