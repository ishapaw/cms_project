import 'package:cms/NavScreens/profile.dart';
import 'package:cms/comments/view.dart';
import 'package:cms/Useful/color.dart';
import 'package:cms/Useful/helper.dart';
import 'package:cms/Useful/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../auth/signin.dart';
import 'add.dart';
import 'all.dart';
import 'dashboard.dart';

class TodayScreen extends StatefulWidget {
  List<dynamic> compl, category;
  Map<String, dynamic> userdata;

  TodayScreen(
      {Key? key,
      required this.compl,
      required this.userdata,
      required this.category})
      : super(key: key);

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  TextEditingController _searchController = TextEditingController();

  int current = 0;
  List<dynamic> d = [];

  List<Color> color = [
    bl,
    Color(0xffFF0F00),
    Color(0xffFA9718),
    Color(0xff00BB13)
  ];

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

  String selectedCategory = "Complainant Name";

  bool isOpen = false;
  var _u1;

  var formattedDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  List<String> dropDownItems1 = ["All"];

  getCategory() {
    for (int i = 0; i < widget.category.length; i++) {
      String cat = widget.category[i]["categoryName"] +
          "-  " +
          "${_u1.where((jsonData) => (jsonData["ComplaintCategory"] == widget.category[i]["categoryName"])).toList().length}";
      print(cat);
      dropDownItems1.add(cat);
    }
  }

  @override
  void initState() {
    _u1 = widget.compl
        .where((jsonData) =>
            DateTime.parse(jsonData["createdAt"])
                .toLocal()
                .toString()
                .substring(0, 10) ==
            formattedDate)
        .toList();
    d = _u1;

    ReadData();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    // TabController tabController = TabController(length: 4, vsync: this);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 10),
                  child: Text(
                    'Today\'s Complaints',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 23),
                  ),
                ),
                Expanded(child: Container()),
                if (widget.userdata["designation"] == "ADGP" ||
                    widget.userdata["designation"] == "SP")
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: lightBlue,
                        borderRadius: BorderRadius.circular(10)),
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
                          print('!!!===== $v');
                        });
                      },
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
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
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          hintText: "search",
                          hintStyle:
                              TextStyle(color: Color(0xff6A5C5C), fontSize: 15),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            print(index);
                            setState(() {
                              current = index;
                            });
                            print(current);
                          },
                          child: scroll(
                            ct[index],
                            filter[index],
                            current == index ? bgBlue : Color(0xff919090),
                            current == index ? color[index] : Color(0xffE0DEDE),
                            current == index ? 4 : 0,
                          ));
                    }),
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
                    // height: 500,
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
                                                  color: _users[current][index][
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
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 60,
                                              child: Text(
                                                _users[current][index]["Status"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: colr[_users[current]
                                                        [index]["Status"]]),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                print(_users[current][index]
                                                    .runtimeType);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            View(
                                                              userdata: widget
                                                                  .userdata,
                                                              isAll: false,
                                                              current: current,
                                                              d: _users[current]
                                                                  [index],
                                                            )));
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
    );
  }

  var user;
  var u1;
  var user2, user3, user4;
  List<List<dynamic>> _users = [];

  List<int> ct = [];

  ReadData() {
    print(formattedDate);

    user2 = d.where((jsonData) => jsonData["highPriority"] == true).toList();
    user3 = d.where((jsonData) => jsonData["Status"] == "PENDING").toList();
    user4 = d.where((jsonData) => jsonData["Status"] == "DISPOSE OFF").toList();

    _users = [d, user2, user3, user4];
    ct = [d.length, user2.length, user3.length, user4.length];
  }

  void updateList(String value) {
    d = _u1;

    setState(() {
      d = d
          .where((jsonData) => jsonData[filters[selectedCategory]]
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    });
  }

  void updateList2(String value) {
    d = _u1;
    setState(() {
      if (value == "All") {
        d = _u1;
      } else {
        d = d
            .where((jsonData) => jsonData["ComplaintCategory"] == value)
            .toList();
      }
    });
  }
}
