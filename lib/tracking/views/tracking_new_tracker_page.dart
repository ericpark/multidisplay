import 'package:flutter/material.dart';

class NewTrackerPage extends StatelessWidget {
  const NewTrackerPage._();
  const NewTrackerPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const NewTrackerPage._());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.check))
        ],
      ),
      body: const Center(child: Placeholder()),
    );
  }
}
