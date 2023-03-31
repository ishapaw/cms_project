import 'dart:convert';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:cms/NavScreens/profile.dart';
import 'package:cms/NavScreens/today.dart';
import 'package:cms/Useful/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'NavScreens/add.dart';
import 'NavScreens/all.dart';
import 'NavScreens/dashboard.dart';
import 'NavScreens/view.dart';
import 'Useful/helper.dart';
import 'Useful/widgets.dart';
import 'auth/signin.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:cms/IO/screen2.dart';
import 'dash_board.dart';

class MainScreen extends StatefulWidget {
  Map<String, dynamic> userdata = {};
  List<dynamic> compl_data = [];
  List<dynamic> district = [];

  MainScreen(
      {Key? key,
      required this.userdata,
      required this.compl_data,
      required this.district})
      : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> widgetOptions = [];
  final controller = PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
          activeColorPrimary: darkBlue,
          inactiveIcon: Icon(
            Icons.home,
            size: 26,
            color: Colors.white,
          ),
          icon: Icon(
            Icons.home,
            size: 30,
            color: darkBlue,
          )),
      PersistentBottomNavBarItem(
          activeColorPrimary: darkBlue,
          inactiveIcon: Icon(
            size: 23,
            Icons.calendar_today_rounded,
            color: Colors.white,
          ),
          icon: Icon(
            Icons.calendar_today_rounded,
            size: 27,
            color: darkBlue,
          )),
      PersistentBottomNavBarItem(
          activeColorPrimary: darkBlue,
          inactiveIcon: Icon(
            size: 23,
            Icons.add_circle,
            color: Colors.white,
          ),
          icon: Icon(
            Icons.add_circle,
            size: 27,
            color: darkBlue,
          )),
      PersistentBottomNavBarItem(
          activeColorPrimary: darkBlue,
          inactiveIcon: Icon(
            Icons.person,
            color: Colors.white,
            size: 23,
          ),
          icon: Icon(
            Icons.person,
            size: 30,
            color: darkBlue,
          )),
    ];
  }

  List<Widget> _buildScreen() {
    return widgetOptions;
  }

  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Map<String, dynamic> d = {};
  List count = [];
  @override
  void initState() {
    d = widget.userdata;
    ReadData();

    setState(() {
      widgetOptions = [
        Dashboard(
          userdata: d,
          compl: widget.compl_data,
          count: count,
          len: 2,
        ),
        TodayScreen(
          compl: widget.compl_data,
        ),
        AddScreen(
          district: widget.district,
        ),
        ProfileScreen(userdata: d)
      ];
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List screen = [
      "All Complaints " +
          "(${_users != null && _users.length > 0 ? _users[0].length : -1})",
      "High Priority Complaints " +
          "(${_users != null && _users.length > 1 ? _users[1].length : -1})",
      "Pending Complaints " +
          "(${_users != null && _users.length > 2 ? _users[2].length : -1})",
      "Closed Complaints " +
          "(${_users != null && _users.length > 3 ? _users[3].length : -1})",
      "Today'\s Complaints " +
          "(${_users != null && _users.length > 4 ? _users[4].length : -1})",
    ];

    print(count);
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            );
          },
        ),
        leadingWidth: 38,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: darkBlue,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/harayana_police_logo.png"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Complain Management System",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            listTile("Profile", Icons.person, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Dash(
                          district: widget.district,
                          data: d,
                          compl: widget.compl_data,
                          body: ProfileScreen(
                            userdata: d,
                          ))));
            }),
            listTile("Dashboard", Icons.dashboard, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Dash(
                            district: widget.district,
                            compl: widget.compl_data,
                            body: Dashboard(
                              userdata: d,
                              compl: widget.compl_data,
                              count: count,
                              len: 3,
                            ),
                            data: d,
                          )));
            }),
            listTile("Add New Complain", Icons.add_circle, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Dash(
                            district: widget.district,
                            compl: widget.compl_data,
                            body: AddScreen(
                              district: widget.district,
                            ),
                            data: d,
                          )));
            }),
            SizedBox(
              height: 5,
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return listTile(screen[index], Icons.calendar_today_rounded,
                        () {
                      if (index != 4) {
                        cur = index;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => All(
                                      compl: widget.compl_data,
                                      curr: index,
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dash(
                                    district: widget.district,
                                    compl: widget.compl_data,
                                    body: TodayScreen(compl: widget.compl_data),
                                    data: d)));
                      }
                    });
                  }),
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
              height: 15,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              height: 5,
            ),
            listTile("LogOut", Icons.logout_rounded, () {
              HelperFunctions.saveuserLoggedInSharePreference(false);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
            })
          ],
        ),
      ),
      body: PersistentTabView(
        context,
        controller: controller,
        screens: _buildScreen(),
        items: _navBarItem(),
        backgroundColor: midBlue,
        hideNavigationBarWhenKeyboardShows: true,
      ),
    );
  }

  var u1, _u1, _u2, _u3, _u4;
  List<List<dynamic>> _users = [];

  var formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  ReadData() {
    u1 = widget.compl_data
        .where((jsonData) =>
            jsonData["createdAt"].substring(0, 10) == formattedDate)
        .toList();
    _u2 = widget.compl_data
        .where((jsonData) => jsonData["ComplaintCategory"] == "CAW")
        .toList();
    _u3 = widget.compl_data
        .where((jsonData) => jsonData["Status"] == "PENDING")
        .toList();
    _u4 = widget.compl_data
        .where((jsonData) => jsonData["Status"] == "CLOSED")
        .toList();

    _users = [widget.compl_data, _u2, _u3, _u4, u1];
  }
}
