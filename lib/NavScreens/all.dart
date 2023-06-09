import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:cms/comments/view.dart';
import 'package:cms/NavScreens/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Useful/color.dart';
import '../Useful/widgets.dart';
import '../dash_board.dart';
import 'dashboard.dart';

class All extends StatefulWidget {
  int curr;
  List<dynamic> compl, category;
  Map<String, dynamic> userdata;
  bool isBlue;

  All(
      {Key? key,
      required this.isBlue,
      required this.curr,
      required this.category,
      required this.compl,
      required this.userdata})
      : super(key: key);

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  int index = 0, current = 0;
  List<String> categoryList = [
    'Complainant Name',
    'Father\'s Name',
    'Phone Number',
    'Address'
  ];

  List<String> categoryList1 = [
    'Complainant Name',
    'Police Station',
    'Father\'s Name',
    'Phone Number',
    'Address'
  ];

  Map<String, String> filters1 = {
    "Complainant Name": "ComplainantName",
    "Police Station": "policestation",
    "Phone Number": "ComplainantPhoneNumber",
    "Father's Name": "FatherName",
    "Address": "Address"
  };

  Map<String, String> filters = {
    "Complainant Name": "ComplainantName",
    "Phone Number": "ComplainantPhoneNumber",
    "Father's Name": "FatherName",
    "Address": "Address"
  };

  TextEditingController _searchController = TextEditingController();

  List<Color> color = [
    bl,
    Color(0xffFF0F00),
    Color(0xffFA9718),
    Color(0xff00BB13)
  ];
  List<dynamic> d = [];

  String selectedCategory = "Complainant Name";

  bool isOpen = false;

  String event_date = "Select date";
  DateTime? date;

  List<String> dropDownItems1 = ["All"];
  String selectedCategory1 = "";

  getCategory() {
    for (int i = 0; i < widget.category.length; i++) {
      String cat = widget.category[i]["categoryName"] +
          "-  " +
          "${widget.compl.where((jsonData) => (jsonData["ComplaintCategory"] == widget.category[i]["categoryName"])).toList().length}";

      dropDownItems1.add(cat);
    }
  }

  List<DropdownMenuItem<String>> getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (int i = 0; i < categoryList.length; i++) {
      String cat = categoryList[i];
      var newItem = DropdownMenuItem(
        child: Text(cat),
        value: cat,
      );
      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }

  @override
  void initState() {
    d = widget.compl;
    current = widget.curr;
    getCategory();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isBlue ? darkBlue : Colors.white,
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: widget.isBlue ? Colors.white : Colors.black),
        centerTitle: widget.isBlue ? true : false,
        title: Row(
          children: [
            Text(
              "All Complaints",
              style: TextStyle(
                color: widget.isBlue ? Colors.white : Colors.black,
              ),
            ),
            Expanded(child: Container()),
            if (widget.userdata["designation"] == "ADGP" ||
                widget.userdata["designation"] == "SP")
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: lightBlue, borderRadius: BorderRadius.circular(10)),
                child: PopupMenuButton<String>(
                  itemBuilder: (context) {
                    return dropDownItems1.map((str) {
                      return PopupMenuItem(
                        value: str,
                        child: Text(str),
                      );
                    }).toList();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Category",
                        style: TextStyle(
                            color: darkBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 13),
                      )
                    ],
                  ),
                  onSelected: (v) {
                    v == "All"
                        ? updateList2(v)
                        : updateList2(
                            v.substring(0, v.indexOf('-')),
                          );
                    setState(() {
                      selectedCategory1 = v;
                    });
                  },
                ),
              ),
          ],
        ),
        elevation: 0,
        backgroundColor: widget.isBlue ? darkBlue : Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      child: InkWell(
                        onTap: () {
                          isOpen = !isOpen;
                          setState(() {});
                        },
                        child: Icon(
                          Icons.filter_list_rounded,
                          color: Colors.black,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: bgBlue,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onChanged: (value) => updateList(value),
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                        ),
                        controller: _searchController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.0),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            hintText: "search",
                            hintStyle: TextStyle(
                                color: Color(0xff6A5C5C), fontSize: 13),
                            filled: true,
                            fillColor: bgBlue,
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 0, style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              if (isOpen)
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
                  child: ListView(
                    primary: true,
                    shrinkWrap: true,
                    children: categoryList
                        .map((e) => Container(
                              padding: EdgeInsets.all(10),
                              color: selectedCategory == e ? darkBlue : bgBlue,
                              child: InkWell(
                                onTap: () {
                                  selectedCategory = e;
                                  isOpen = false;
                                  setState(() {});
                                },
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      color: selectedCategory == e
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    borderbtnsss(event_date, () async {
                      final initialDate = DateTime.now();
                      final newDate = await showDatePicker(
                        context: context,
                        initialDate: date ?? initialDate,
                        firstDate: DateTime(DateTime.now().year - 5),
                        lastDate: DateTime(DateTime.now().year + 5),
                      );

                      if (newDate == null) return;

                      setState(() {
                        date = newDate;
                        event_date = DateFormat('yyyy-MM-dd').format(date!);
                        updateList1(event_date);
                        // super.setState(() {});
                      });
                    }, darkBlue, lightBlue),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    current = index;
                                  });
                                },
                                child: scroll(
                                  _users != null && _users.length > index
                                      ? _users[index].length
                                      : 0,
                                  filter[index],
                                  current == index ? bgBlue : Color(0xff919090),
                                  current == index
                                      ? color[index]
                                      : Color(0xffE0DEDE),
                                  current == index ? 4 : 0,
                                ));
                          }),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
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
                          width: 10,
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                      height: 15,
                      indent: 0,
                      endIndent: 0,
                    ),
                    Expanded(
                      child: FutureBuilder(
                          future: ReadData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text('Loading');
                            } else {
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: _users[current].length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 110,
                                                child: Text(
                                                  _users[current][index]
                                                          ["ComplainantName"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: _users[current]
                                                                    [index][
                                                                "highPriority"] ==
                                                            true
                                                        ? Colors.red
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 90,
                                                child: Text(
                                                  _users[current][index]
                                                          ["ComplaintCategory"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Container(
                                                width: 60,
                                                child: Text(
                                                  _users[current][index]
                                                          ["Status"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: colr[_users[current]
                                                        [index]["Status"]],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            View(
                                                          userdata:
                                                              widget.userdata,
                                                          isAll: widget.isBlue,
                                                          current: current,
                                                          d: _users[current]
                                                              [index],
                                                        ),
                                                      ));
                                                },
                                                child: Icon(
                                                  Icons.more_vert,
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.black,
                                          thickness: 1,
                                          height: 15,
                                          indent: 0,
                                          endIndent: 0,
                                        ),
                                      ],
                                    );
                                  });
                            }
                          }),
                    ),
                  ],
                ),
                color: Colors.white,
                padding: EdgeInsets.all(20.0),
              ))
            ],
          ),
        ),
      ),
    );
  }

  var u1, u2, u3, u4;
  List<List<dynamic>> _users = [];

  ReadData() {
    u2 = d.where((jsonData) => jsonData["highPriority"] == true).toList();
    u3 = d.where((jsonData) => jsonData["Status"] == "PENDING").toList();
    u4 = d.where((jsonData) => jsonData["Status"] == "DISPOSE OFF").toList();

    _users = [d, u2, u3, u4];
  }

  void updateList(String value) {
    d = widget.compl;
    setState(() {
      d = d
          .where((jsonData) => jsonData[filters[selectedCategory]]
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    });
  }

  void updateList1(var value) {
    d = widget.compl;
    setState(() {
      d = d
          .where((jsonData) =>
              DateTime.parse(jsonData["createdAt"])
                  .toLocal()
                  .toString()
                  .substring(0, 10) ==
              value)
          .toList();
    });
  }

  void updateList2(String value) {
    d = widget.compl;
    setState(() {
      if (value == "All") {
        d = widget.compl;
      } else {
        d = d
            .where((jsonData) => jsonData["ComplaintCategory"] == value)
            .toList();
      }
    });
  }
}
