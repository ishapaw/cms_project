import 'dart:convert';
import 'package:cms/comments/view_all.dart';
import 'package:intl/intl.dart';
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
import '../comments/view.dart';
import '../dash_board.dart';
import 'all.dart';

class Dashboard extends StatefulWidget {
  Map<String, dynamic> userdata = {};
  List<dynamic> compl, io, pol, cat, dis;

  List count = [];

  Dashboard({
    Key? key,
    required this.dis,
    required this.pol,
    required this.cat,
    required this.io,
    required this.userdata,
    required this.compl,
    required this.count,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

int cur = 0;

class _DashboardState extends State<Dashboard> {
  var user;
  var u1, u2, u3, u4, u5, u6;

  List ct = [];

  @override
  void initState() {
    print(widget.dis);
    ReadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ct = widget.count;
    print(widget.io.length);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome,',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 23),
                ),
                Text(
                  widget.userdata != null
                      ? widget.userdata["designation"] +
                          ", " +
                          widget.userdata["fname"] +
                          " " +
                          widget.userdata["lname"]
                      : "oho",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 13),
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
                        "Total Complaints",
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => All(
                                      isBlue: false,
                                      userdata: widget.userdata,
                                      category: widget.cat,
                                      compl: widget.compl,
                                      curr: 0,
                                    )))),
                    SizedBox(
                      width: 15,
                    ),
                    card(
                        context,
                        _u1.length,
                        "Today's Complaints",
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TodayScreen(
                                  category: widget.cat,
                                  userdata: widget.userdata,
                                  compl: widget.compl),
                            ))),
                    Spacer()
                  ],
                ),
                Row(
                  children: [
                    Spacer(),
                    card(
                        context,
                        _users != null && _users.length > 1
                            ? _users[1].length
                            : -1,
                        "Pending Complaints",
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => All(
                                      isBlue: false,
                                      userdata: widget.userdata,
                                      category: widget.cat,
                                      compl: widget.compl,
                                      curr: 2,
                                    )))),
                    SizedBox(
                      width: 15,
                    ),
                    card(
                        context,
                        _users != null && _users.length > 1
                            ? _users[2].length
                            : -1,
                        "Dispose Off Complaints",
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => All(
                                      isBlue: false,
                                      userdata: widget.userdata,
                                      category: widget.cat,
                                      compl: widget.compl,
                                      curr: 3,
                                    )))),
                    Spacer()
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                if (widget.userdata["designation"] != "IO")
                  Row(
                    children: [
                      Text(
                        widget.userdata["designation"] == "SHO"
                            ? "Investigation Officers"
                            : widget.userdata["designation"] == "ADGP"
                                ? "Districts"
                                : "Police Stations",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewAll(
                                  dis: widget.dis,
                                  cat: widget.cat,
                                  title: widget.userdata["designation"] == "SHO"
                                      ? "Investigation Officers"
                                      : widget.userdata["designation"] == "ADGP"
                                          ? "Districts"
                                          : "Police Stations",
                                  io: widget.io,
                                  pol: widget.pol,
                                  compl: widget.compl,
                                  userdata: widget.userdata,
                                ),
                              ));
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                              fontSize: 11,
                              color: darkBlue,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: 10)
                    ],
                  ),
                SizedBox(
                  height: 5,
                ),
                if (widget.userdata["designation"] != "IO")
                  Container(
                    height: 220,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.userdata["designation"] == "ADGP"
                            ? widget.dis.length == 0
                                ? 0
                                : widget.dis.length
                            : widget.userdata["designation"] == "SHO"
                                ? widget.io.length == 0
                                    ? 0
                                    : widget.io.length
                                : widget.pol.length == 0
                                    ? 0
                                    : widget.pol.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              SizedBox(width: 5),
                              widget.userdata["designation"] == "ADGP"
                                  ? ver_card(
                                      context,
                                      widget.compl.where((jsonData) => jsonData["rangeDistrictName"] == widget.dis[index]["rangeDistrictName"]).toList() !=
                                              null
                                          ? widget.compl
                                              .where((jsonData) =>
                                                  jsonData["rangeDistrictName"] ==
                                                  widget.dis[index]
                                                      ["rangeDistrictName"])
                                              .toList()
                                              .length
                                          : 0,
                                      widget.compl
                                                  .where((jsonData) =>
                                                      jsonData["rangeDistrictName"] ==
                                                      widget.dis[index]
                                                          ["rangeDistrictName"])
                                                  .toList() !=
                                              null
                                          ? widget.compl
                                              .where((jsonData) =>
                                                  (jsonData["rangeDistrictName"] ==
                                                      widget.dis[index]
                                                          ["rangeDistrictName"]) &&
                                                  (jsonData["Status"] == "PENDING"))
                                              .toList()
                                              .length
                                          : 0,
                                      widget.dis[index]["rangeDistrictName"],
                                      widget.dis[index]["rangeDistrictName"],
                                      widget.userdata,
                                      widget.compl,
                                      widget.pol.where((jsonData) => jsonData["policeStationDistrict"] == widget.dis[index]["rangeDistrictName"]).toList(),
                                      widget.cat)
                                  : widget.userdata["designation"] == "SHO"
                                      ? ver_card(context, widget.compl.where((jsonData) => jsonData["Markto"] == widget.io[index]["email"].toLowerCase()).toList() != null ? widget.compl.where((jsonData) => jsonData["Markto"] == widget.io[index]["email"].toLowerCase()).toList().length : 0, widget.compl.where((jsonData) => jsonData["Markto"] == widget.io[index]["email"].toLowerCase()).toList() != null ? widget.compl.where((jsonData) => (jsonData["Markto"] == widget.io[index]["email"].toLowerCase()) && (jsonData["Status"] == "PENDING")).toList().length : 0, widget.io[index]["fname"] + " " + widget.io[index]["lname"], widget.io[index]["email"].toLowerCase(), widget.userdata, widget.compl, widget.pol, widget.cat)
                                      : ver_card(context, widget.compl.where((jsonData) => jsonData["policestation"] == widget.pol[index]["policeStationName"]).toList() != null ? widget.compl.where((jsonData) => jsonData["policestation"] == widget.pol[index]["policeStationName"]).toList().length : 0, widget.compl.where((jsonData) => jsonData["policestation"] == widget.pol[index]["policeStationName"]).toList() != null ? widget.compl.where((jsonData) => (jsonData["policestation"] == widget.pol[index]["policeStationName"]) && (jsonData["Status"] == "PENDING")).toList().length : 0, widget.pol[index]["policeStationName"], widget.pol[index]["policeStationName"], widget.userdata, widget.compl.where((jsonData) => jsonData["policestation"] == widget.pol[index]["policeStationName"]).toList(), widget.pol.where((jsonData) => jsonData["policeStationDistrict"] == widget.pol[index]["rangeDistrictName"]).toList(), widget.cat),
                              SizedBox(width: 15)
                            ],
                          );
                        }),
                  ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "Today's Complaints",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TodayScreen(
                                  category: widget.cat,
                                  userdata: widget.userdata,
                                  compl: widget.compl),
                            ));
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                            fontSize: 11,
                            color: darkBlue,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(width: 10)
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Compl. Name",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Category",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            "Status",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 2,
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      _u1.length != 0
                          ? Container(
                              color: Colors.white,
                              height: widget.userdata["designation"] != "IO"
                                  ? MediaQuery.of(context).size.height / 20
                                  : MediaQuery.of(context).size.height / 3,
                              child: FutureBuilder(
                                  future: ReadData(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text('Loading');
                                    } else {
                                      return ListView.builder(
                                          itemCount:
                                              widget.userdata["designation"] !=
                                                      "IO"
                                                  ? 1
                                                  : _u1.length,
                                          itemBuilder: (context, index) {
                                            if (_u1 != [] &&
                                                _u1[index]["ComplainantName"] !=
                                                    null) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    child: Text(
                                                      _u1[index][
                                                              "ComplainantName"]
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: _u1[index][
                                                                    "highPriority"] ==
                                                                true
                                                            ? Colors.red
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 80,
                                                    child: Text(
                                                      _u1[index][
                                                              "ComplaintCategory"]
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 80,
                                                    child: Text(
                                                      _u1[index]["Status"]
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: colr[_u1[index]
                                                                ["Status"]
                                                            .toString()],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                            return Container();
                                          });
                                    }
                                  }),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "No Complaints added Today",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
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

  var _u1, _u3, _u4;
  List<List<dynamic>> _users = [];
  var formattedDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  ReadData() {
    print("ye rhi ${formattedDate}");
    _u1 = widget.compl
        .where((jsonData) =>
            DateTime.parse(jsonData["createdAt"])
                .toLocal()
                .toString()
                .substring(0, 10) ==
            formattedDate)
        .toList();
    _u3 = widget.compl
        .where((jsonData) => jsonData["Status"] == "PENDING")
        .toList();
    _u4 = widget.compl
        .where((jsonData) => jsonData["Status"] == "DISPOSE OFF")
        .toList();

    _users = [widget.compl, _u3, _u4];
  }
}
