import 'dart:convert';

import 'package:cms/NavScreens/add.dart';
import 'package:cms/NavScreens/profile.dart';
import 'package:cms/NavScreens/today.dart';
import 'package:cms/Useful/color.dart';
import 'package:cms/auth/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Useful/func.dart';
import '../Useful/helper.dart';
import '../Useful/widgets.dart';
import '../test_api.dart';
import 'all.dart';

class Dashboard extends StatefulWidget {
  Map<String, dynamic> userdata = {};
  List<dynamic> compl = [];
  List count = [];
  int len;

  Dashboard(
      {Key? key,
      required this.userdata,
      required this.compl,
      required this.count,
      required this.len})
      : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

int cur = 0;

class _DashboardState extends State<Dashboard> {
  var user;
  var u1, u2, u3, u4, u5, u6;
  getNum() {
    setState(() {
      u1 = widget.compl
          .where((jsonData) => jsonData["Markto"] == "satishjain")
          .toList();
      u2 = widget.compl
          .where((jsonData) => jsonData["Markto"] == "rakeshmishra")
          .toList();
      u3 = widget.compl
          .where((jsonData) => jsonData["Markto"] == "sahilsharma")
          .toList();
      u4 = widget.compl
          .where((jsonData) => jsonData["Markto"] == "rohitpawar")
          .toList();
      u5 = widget.compl
          .where((jsonData) => jsonData["Markto"] == "satishyadav")
          .toList();
      u6 = widget.compl
          .where((jsonData) => jsonData["Markto"] == "gauravpandey")
          .toList();
    });
  }

  List ct = [];

  @override
  void initState() {
    print(ct);
    getNum();
    ReadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("aaya ${widget.compl}");
    ct = widget.count;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome,',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
                ),
                Text(
                  widget.userdata != null
                      ? widget.userdata["fname"] +
                          " " +
                          widget.userdata["lname"]
                      : "oho",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Spacer(),
                    card(
                        context,
                        _users != null && _users.length > 0
                            ? _users[0].length
                            : -1,
                        "Total Complaints"),
                    SizedBox(
                      width: 15,
                    ),
                    card(
                        context,
                        _users != null && _users.length > 1
                            ? _users[1].length
                            : -1,
                        "CAW Complaints"),
                    Spacer()
                  ],
                ),
                Row(
                  children: [
                    Spacer(),
                    card(
                        context,
                        _users != null && _users.length > 2
                            ? _users[2].length
                            : -1,
                        "Pending Complaints"),
                    SizedBox(
                      width: 15,
                    ),
                    card(
                        context,
                        _users != null && _users.length > 3
                            ? _users[3].length
                            : -1,
                        "Closed Complaints"),
                    Spacer()
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Investigation Officers",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Text(
                      "View All",
                      style: TextStyle(
                          fontSize: 13,
                          color: darkBlue,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        ver_card(context, u1 != null ? u1.length : 0,
                            "Satish Jain", "satishjain",widget.compl),
                        SizedBox(
                          width: 20,
                        ),
                        ver_card(context, u2 != null ? u2.length : 0,
                            "Rakesh Mishra", "rakeshmishra",widget.compl),
                        SizedBox(
                          width: 20,
                        ),
                        ver_card(context, u3 != null ? u3.length : 0,
                            "Sahil Sharma", "sahilsharma",widget.compl),
                        SizedBox(
                          width: 20,
                        ),
                        ver_card(context, u4 != null ? u4.length : 0,
                            "Rohit Pawar", "rohitpawar",widget.compl),
                        SizedBox(
                          width: 20,
                        ),
                        ver_card(
                          context,
                          u5 != null ? u5.length : 0,
                          "Satish Yadav",
                          "satishyadav"
                            ,widget.compl
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ver_card(context, u6 != null ? u6.length : 0,
                            "Gaurav Pandey", "gauravpandey",widget.compl)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "High Stake Complaints",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Text(
                      "View All",
                      style: TextStyle(
                          fontSize: 13,
                          color: darkBlue,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "ComplainantName",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Category",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            "Status",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: widget.len == 2
                            ? MediaQuery.of(context).size.height / 15
                            : MediaQuery.of(context).size.height / 8,
                        child: FutureBuilder(
                            future: ReadData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text('Loading');
                              } else {
                                return ListView.builder(
                                    itemCount: widget.len,
                                    itemBuilder: (context, index) {
                                      print(widget.len);
                                      if (widget.compl != [] &&
                                          widget.compl[index]
                                                  ["ComplainantName"] !=
                                              null) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 150,
                                                child: Text(
                                                  widget.compl[index]
                                                          ["ComplainantName"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                widget.compl[index]
                                                        ["ComplaintCategory"]
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              SizedBox(
                                                width: 65,
                                              ),
                                              Text(
                                                widget.compl[index]["Status"]
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return Container();
                                    });
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  var _u2, _u3, _u4;
  List<List<dynamic>> _users = [];

  ReadData() {
    _u2 = widget.compl
        .where((jsonData) => jsonData["ComplaintCategory"] == "CAW")
        .toList();
    _u3 = widget.compl
        .where((jsonData) => jsonData["Status"] == "PENDING")
        .toList();
    _u4 = widget.compl
        .where((jsonData) => jsonData["Status"] == "CLOSED")
        .toList();

    _users = [widget.compl, _u2, _u3, _u4];
  }
}
