class Item {
  final String question;
  final String answer;

  Item({required this.question, required this.answer});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      question: json['Q'] as String? ?? '',
      answer: json['A'] as String? ?? '',
    );
  }
}
