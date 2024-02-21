/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:multidisplay/calendar/view/calendar_page.dart';
import 'package:multidisplay/expenses/expenses_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var tabIndex = 0;
  var numberOfPages = 3;
  PageController pageController = PageController();
  var pageChanged = 0;
  var autoScroll = true;
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (autoScroll) {
        setState(() {
          pageChanged = ((pageChanged + 1) % numberOfPages);
        });
        pageController.animateToPage(pageChanged,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOutCubicEmphasized);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        pageSnapping: true,
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            pageChanged = index;
          });
          print(pageChanged);
        },
        children: const [HomePage(), CalendarPage(), ExpensePage()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          setState(() {
            autoScroll = !autoScroll;
          })
        },
        tooltip: 'Next Page',
        child:
            autoScroll ? const Icon(Icons.lock_open) : const Icon(Icons.lock),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endTop, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/