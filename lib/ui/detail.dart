import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:toughest/models/items.dart';
import 'package:toughest/ui/showDetail.dart';

// DetailScreen: loads local json and shows questions in a list. Kept stateless by
// delegating async work to a FutureBuilder. Error handling is minimal but indicated.
class DetailScreen extends StatelessWidget {
  final String title;
  const DetailScreen({super.key, required this.title});

  String _typeFromTitle() {
    switch (title) {
      case 'Behavioural Based':
        return 'Behaviour';
      case 'Communications Based':
        return 'Communication';
      case 'Opinion Based':
        return 'Opinion';
      case 'Performance Based':
        return 'Performance';
      default:
        return 'Brainteasures';
    }
  }

  Future<List<Item>> _loadItems() async {
    final type = _typeFromTitle();
    final jsonString = await rootBundle.loadString('assets/local.json');
    final decoded = json.decode(jsonString) as Map<String, dynamic>;
    final list = decoded[type] as List<dynamic>? ?? [];
    return list.map((e) => Item.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Questions')),
      body: FutureBuilder<List<Item>>(
        future: _loadItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Failed to load questions'));
          }

          final items = snapshot.data ?? [];
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item.question,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500)),
                trailing: IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {/* Share question */}),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ShowDetailScreen(item: item))),
              );
            },
          );
        },
      ),
    );
  }
}
