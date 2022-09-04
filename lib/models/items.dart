//these two classes are here to help in decoding json data.
class ItemList {
  List<Item> list;
  ItemList({required this.list});

  factory ItemList.fromJson(List<dynamic> parsedJson) {
    var lists = parsedJson;
    List<Item> itemLists = lists.map((f) => Item.fromJson(f)).toList();
    return ItemList(list: itemLists);
  }
}

class Item {
  String question, answer;
  Item({required this.question, required this.answer});

  factory Item.fromJson(Map<String, dynamic> parsedJson) {
    return Item(question: parsedJson['Q'], answer: parsedJson['A']);
  }
}
