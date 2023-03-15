import 'package:cms/NavScreens/profile.dart';
import 'package:cms/NavScreens/today.dart';
import 'package:cms/Useful/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'NavScreens/add.dart';
import 'NavScreens/dashboard.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widget_Options = <Widget>[
    Text("Index 0:Home"),
    Text("Index 0:Home"),
    Text("Index 0:Home"),
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: midBlue,
          inactiveColor: Colors.white,
          activeColor: Colors.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_today_rounded,
                size: 25,
              ),
            ),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.add_circle,
              size: 25,
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.person,
              size: 28,
            ))
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: Dashboard());
                },
              );

            case 2:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: AddScreen());
                },
              );

            case 1:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: TodayScreen());
                },
              );

            case 3:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: ProfileScreen());
                },
              );
          }
          return Container();
        });
  }
}
