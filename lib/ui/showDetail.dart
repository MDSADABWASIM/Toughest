import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toughest/models/items.dart';

// ShowDetailScreen displays a question and answer. It plays a one-time confetti
// animation (Lottie) when the page is shown. Controller is disposed properly.
class ShowDetailScreen extends StatefulWidget {
  final Item item;
  const ShowDetailScreen({super.key, required this.item});

  @override
  State<ShowDetailScreen> createState() => _ShowDetailScreenState();
}

class _ShowDetailScreenState extends State<ShowDetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _share() {
    Share.share('Q: ${widget.item.question}\n\nA: ${widget.item.answer}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Answer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Question:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(widget.item.question,
                    style: const TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Answer:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(widget.item.answer,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 20),
                        // Lottie confetti plays once when loaded
                        Lottie.asset('assets/confetti.json',
                            controller: _controller,
                            repeat: false, onLoaded: (composition) {
                          _controller
                            ..duration = composition.duration
                            ..forward();
                        }),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                            onPressed: _share,
                            icon: const Icon(Icons.share),
                            label: const Text('Share the answer')),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
