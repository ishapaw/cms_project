import 'package:flutter/material.dart';

import '../NavScreens/view.dart';
import '../Useful/color.dart';
import '../Useful/widgets.dart';

class IOScreen extends StatefulWidget {
  String mark_to;
  String officer;
  List<dynamic> compl;
  IOScreen(
      {Key? key,
      required this.mark_to,
      required this.compl,
      required this.officer})
      : super(key: key);

  @override
  State<IOScreen> createState() => IOScreenState();
}

class IOScreenState extends State<IOScreen> {
  int current = 0, index = 0;

  TextEditingController _searchController = TextEditingController();
  List<String> filter = ["All", "High Priority", "Pending", "Closed"];

  List<Color> color = [
    bl,
    Color(0xffFF0F00),
    Color(0xffFA9718),
    Color(0xff00BB13)
  ];
  List<dynamic> d = [];

  String selectedCategory = "Complainant Name";

  List<String> categoryList = [
    'Complainant Name',
    'Father\'s Name',
    'Phone Number'
  ];
  bool isOpen = false;

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

  var _u1;

  @override
  void initState() {
    _u1 = widget.compl
        .where((jsonData) => jsonData["Markto"] == widget.mark_to)
        .toList();
    print("ye lo ${_u1}");
    d = _u1;
    ReadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 10),
                  child: Text(
                    "IO - ${widget.officer}",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
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
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10.0),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "search",
                              hintStyle: TextStyle(
                                  color: Color(0xff6A5C5C), fontSize: 15),
                              filled: true,
                              fillColor: bgBlue,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
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
                                color:
                                    selectedCategory == e ? darkBlue : bgBlue,
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
                Expanded(
                    child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "ComplainantName",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Category",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            "Status",
                            style: TextStyle(
                                fontSize: 15,
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
                                      print(_users[current].length);
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 150,
                                                  child: Text(
                                                    _users[current][index]
                                                            ["ComplainantName"]
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  width: 80,
                                                  child: Text(
                                                    _users[current][index][
                                                            "ComplaintCategory"]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  width: 75,
                                                  child: Text(
                                                    _users[current][index]
                                                            ["Status"]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black),
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
                                                            isAll: false,
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
      ),
    );
  }

  var u2, u3, u4;
  List<List<dynamic>> _users = [];

  ReadData() {
    u2 = d.where((jsonData) => jsonData["highPriority"] == true).toList();
    u3 = d.where((jsonData) => jsonData["Status"] == "PENDING").toList();
    u4 = d.where((jsonData) => jsonData["Status"] == "CLOSED").toList();

    _users = [d, u2, u3, u4];
  }

  Map<String, String> filters = {
    "Complainant Name": "ComplainantName",
    "Phone Number": "ComplainantPhoneNumber",
    "Father's Name": "FatherName"
  };

  void updateList(String value) {
    d = _u1;
    setState(() {
      d = d
          .where((jsonData) => jsonData[filters[selectedCategory]]
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();

      print("${d}");
    });
  }
}
