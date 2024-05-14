import 'package:custom_components/custom_components.dart';
import 'package:flutter/material.dart';
import 'package:multidisplay/expenses/widgets/add_expense_fab.dart';

// Project
//import 'package:multidisplay/expenses/expenses.dart';

class ExpensesSpendingView extends StatelessWidget {
  const ExpensesSpendingView({super.key});

  @override
  Widget build(BuildContext context) {
    const exampleWidget = Padding(
      padding: EdgeInsets.all(8),
      child: SizedBox(
        height: 200,
        width: 350,
        child: ColoredBox(
          color: Colors.white,
          child: ContentPlaceholder(lineType: ContentLineType.threeLines),
        ),
      ),
    );

    const summaryHeader = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        exampleWidget,
        exampleWidget,
        exampleWidget,
      ],
    );

    const spacing = SizedBox(height: 10);
    final theme = Theme.of(context);
    final sectionHeader = SizedBox(
      width: double.infinity,
      child: Text(
        'APRIL 2024',
        style: theme.textTheme.headlineLarge!
            .copyWith(fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    );

    const karmaChip = Padding(
      padding: EdgeInsets.all(4),
      child: SizedBox(
        child: Chip(
          avatar: Icon(Icons.auto_awesome_rounded),
          label: Text('Karma'),
        ),
      ),
    );
    const reoccurringChip = Padding(
      padding: EdgeInsets.all(4),
      child: SizedBox(
        child: Chip(
          avatar: Icon(Icons.event_repeat_outlined),
          label: Text('Reoccurring'),
        ),
      ),
    );
    const unnecessaryChip = Padding(
      padding: EdgeInsets.all(4),
      child: SizedBox(
        child: Chip(
          avatar: Icon(Icons.sentiment_very_dissatisfied_outlined),
          label: Text('Unnecessary'),
        ),
      ),
    );
    const foodChip = Padding(
      padding: EdgeInsets.all(4),
      child: SizedBox(
        child: Chip(
          avatar: Icon(Icons.fastfood_outlined),
          label: Text('Food'),
        ),
      ),
    );
    final transactionRow = Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: ColoredBox(
          color: Colors.white,
          child: Column(
            children: [
              const Expanded(
                child: ContentPlaceholder(
                  lineType: ContentLineType.threeLines,
                ),
              ),
              SizedBox(
                height: 50,
                width: 1150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    karmaChip,
                    reoccurringChip,
                    unnecessaryChip,
                    foodChip,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        primary: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.filter_alt_sharp,
              semanticLabel: 'Filter Expenses',
            ),
            onPressed: () async {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              summaryHeader,
              spacing,
              sectionHeader,
              spacing,
              transactionRow,
              transactionRow,
              transactionRow,
              transactionRow,
              transactionRow,
              sectionHeader,
              spacing,
              transactionRow,
              transactionRow,
              transactionRow,
              transactionRow,
              transactionRow,
            ],
          ),
        ),
      ),
      floatingActionButton: const AddExpenseFAB(),
    );
  }
}
