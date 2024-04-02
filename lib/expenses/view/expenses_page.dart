import 'package:flutter/material.dart';

// Project
import 'package:multidisplay/expenses/expenses.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 400) {
          return const ExpensesLayoutMobile();
        }
        return const ExpensesLayoutTablet();
      },
    );
  }
}
