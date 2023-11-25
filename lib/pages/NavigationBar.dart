import 'dart:io';

import 'package:flutter/material.dart';
import 'package:teachers_app/pages/community_page.dart';
import 'package:teachers_app/pages/groupPage.dart';
import 'package:teachers_app/pages/teacher_dashboard.dart';

void main() {
  runApp(const CustomNavBar());
}

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({Key? key}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Bottom NavBar Demo',
      // theme: ThemeData(
      //   primaryColor: const Color(0xff2F8D46),
      //   splashColor: Colors.transparent,
      //   highlightColor: Colors.transparent,
      //   hoverColor: Colors.transparent,
      // ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  static const double unselectedIconSize = 25;
  static const double selectedIconSize = 35;
  double dashboardIconSize = selectedIconSize;
  double inboxIconSize = unselectedIconSize;
  double communityIconSize = unselectedIconSize;

  static const MaterialColor unselectedColor = Colors.grey;
  static const MaterialColor selectedColor = Colors.blue;
  MaterialColor dashboardColor = selectedColor;
  MaterialColor inboxColor = unselectedColor;
  MaterialColor communityColor = unselectedColor;


  final pages = [
    const DashBoard(),
    const Page2(),
    const GroupPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  ClipRRect buildMyNavBar(BuildContext context) {
    return  ClipRRect(
    borderRadius: const BorderRadius.only(
        topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
    child: BottomNavigationBar(
      //type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.grey[100],
      currentIndex: pageIndex,
      items: [
        BottomNavigationBarItem(
          icon: IconButton(
            enableFeedback: false,
            icon: const Icon(Icons.dashboard),
            iconSize: dashboardIconSize,
            color: dashboardColor,
            onPressed: () {
              setState(() {
                pageIndex = 0;
                dashboardIconSize = selectedIconSize;
                inboxIconSize = communityIconSize = unselectedIconSize;
                dashboardColor = selectedColor;
                inboxColor = communityColor = unselectedColor;



              });
            },
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            enableFeedback: false,
            icon: const Icon(Icons.inbox),

            iconSize: inboxIconSize,
            color: inboxColor,
            onPressed: () {
              setState(() {
                pageIndex = 1;
                inboxIconSize = selectedIconSize;
                dashboardIconSize = communityIconSize = unselectedIconSize;

                inboxColor = selectedColor;
                dashboardColor = communityColor = unselectedColor;
              });
            },
          ),
          label: 'Inbox',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            enableFeedback: false,
            icon: const Icon(Icons.group),
            iconSize: communityIconSize,
            color: communityColor,
            onPressed: () {
              setState(() {
                pageIndex = 2;
                communityIconSize = selectedIconSize;
                dashboardIconSize = inboxIconSize = unselectedIconSize;

                communityColor = selectedColor;
                inboxColor = dashboardColor = unselectedColor;
              });
            },
          ),
          label: 'Community',
        ),
      ],
    ),

    );

    /*return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),

      child:       Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
              Icons.home_filled,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
              Icons.work_rounded,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.work_outline_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
              Icons.widgets_rounded,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.widgets_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? const Icon(
              Icons.person,
              color: Colors.white,
              size: 35,
            )
                : const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
    );*/
  }
}



class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC4DFCB),
      child: Center(
        child: Text(
          "Page Number 2",
          style: TextStyle(
            color: Colors.green[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}


