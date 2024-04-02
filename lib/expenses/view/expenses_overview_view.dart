import 'package:flutter/material.dart';

// Project
import 'package:multidisplay/expenses/expenses.dart';

class ExpensesOverviewView extends StatelessWidget {
  const ExpensesOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SpendingSection(
            sectionName: "Overview",
          )
        ],
      ),
    );
  }
}
