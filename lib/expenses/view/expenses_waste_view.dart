import 'package:flutter/material.dart';

// Project
import 'package:multidisplay/expenses/expenses.dart';

class ExpensesWasteView extends StatelessWidget {
  const ExpensesWasteView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'This Page should track spending waste.',
          ),
        ],
      ),
    );
  }
}
