import 'package:flutter/material.dart';

//Project
import 'package:multidisplay/expenses/expenses.dart';

class ExpensesLayoutTablet extends StatelessWidget {
  const ExpensesLayoutTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.track_changes_outlined)),
                Tab(icon: Icon(Icons.attach_money_outlined)),
                Tab(icon: Icon(Icons.delete)),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            ExpensesOverviewView(),
            ExpensesSpendingView(),
            ExpensesWasteView(),
          ],
        ),
      ),
    );
  }
}
