import 'package:cms/IO/screen3.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../comments/view.dart';
import '../Useful/color.dart';
import '../Useful/widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class IOScreen extends StatefulWidget {
  String mark_to;
  String officer;
  List<dynamic> compl, pol, category;
  Map<String, dynamic> userdata;
  IOScreen(
      {Key? key,
      required this.mark_to,
      required this.category,
      required this.compl,
      required this.pol,
      required this.officer,
      required this.userdata})
      : super(key: key);

  @override
  State<IOScreen> createState() => IOScreenState();
}

class IOScreenState extends State<IOScreen> {
  int current = 0, index = 0;

  TextEditingController _searchController = TextEditingController();

  List<String> _filter = [
    "All",
    "Today",
    "High Priority",
    "Pending",
    "Dispose Off"
  ];

  List<Color> color = [
    bl,
    bl,
    Color(0xffFF0F00),
    Color(0xffFA9718),
    Color(0xff00BB13)
  ];
  List<dynamic> d = [];

  String selectedCategory = "";

  bool isOpen = false;
  List<String> dropDownItems2 = [];

  getPol() {
    for (int i = 0; i < widget.pol.length; i++) {
      String cat = widget.pol.length != 0
          ? widget.pol[i]["policeStationName"] +
              "-  " +
              "${widget.compl.where((jsonData) => jsonData["policestation"] == widget.pol[i]["policeStationName"]).toList().length}"
          : " ";
      dropDownItems2.add(cat);
    }
  }

  List<String> dropDownItems1 = ["All"];

  getCategory() {
    for (int i = 0; i < widget.category.length; i++) {
      String cat = widget.userdata["designation"] == "ADGP"
          ? widget.category[i]["categoryName"] +
              "-  " +
              "${widget.compl.where((jsonData) => (jsonData["ComplaintCategory"] == widget.category[i]["categoryName"] && jsonData["rangeDistrictName"] == widget.mark_to)).toList().length}"
          : widget.category[i]["categoryName"] +
              "-  " +
              "${widget.compl.where((jsonData) => (jsonData["ComplaintCategory"] == widget.category[i]["categoryName"] && jsonData["policestation"] == widget.mark_to)).toList().length}";
      dropDownItems1.add(cat);
    }
  }

  var _u1;

  String event_date = "Select date";
  DateTime? date;

  String selectedCategory2 = "";
  String selectedCategory1 = "";

  @override
  void initState() {
    if (widget.userdata["designation"] == "ADGP" && widget.pol.length != 0)
      getPol();

    getCategory();

    _u1 = widget.userdata["designation"] == "ADGP"
        ? widget.compl
            .where(
                (jsonData) => jsonData["rangeDistrictName"] == widget.mark_to)
            .toList()
        : widget.userdata["designation"] == "SHO"
            ? widget.compl
                .where((jsonData) => jsonData["Markto"] == widget.mark_to)
                .toList()
            : widget.compl
                .where(
                    (jsonData) => jsonData["policestation"] == widget.mark_to)
                .toList();

    d = _u1;
    ReadData();
    selectedCategory2 =
        widget.pol.length != 0 ? widget.pol[0]["policeStationName"] : " ";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Text(
              widget.userdata["designation"] == "SHO"
                  ? "IO - ${widget.officer}"
                  : "${widget.officer}",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: widget.userdata["designation"] == "ADGP" ? 20 : 17),
            ),
            SizedBox(
              width: 10,
            ),
            if (widget.userdata["designation"] == "ADGP" && widget.pol != null)
              PopupMenuButton<String>(
                itemBuilder: (context) {
                  return dropDownItems2.map((str) {
                    return PopupMenuItem(
                      value: str,
                      child: Text(str),
                    );
                  }).toList();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                  ],
                ),
                onSelected: (v) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PSscreen(
                              category: widget.category,
                              pol: v.substring(0, v.indexOf('-')),
                              compl: widget.compl,
                              userdata: widget.userdata)));
                  setState(() {
                    selectedCategory2 = v;
                  });
                },
              ),
            Expanded(
              child: Container(),
            ),
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
            SizedBox(
              width: 10,
            ),
          ],
        ),
        iconTheme: IconThemeData(color: Colors.black),
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          itemCount: 5,
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
                                  _filter[index],
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
                                                      color: Colors.black),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
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
    );
  }

  var u1, u2, u3, u4;
  List<List<dynamic>> _users = [];

  var formattedDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  ReadData() {
    u1 = d
        .where((jsonData) =>
            DateTime.parse(jsonData["createdAt"])
                .toLocal()
                .toString()
                .substring(0, 10) ==
            formattedDate)
        .toList();
    u2 = d.where((jsonData) => jsonData["highPriority"] == true).toList();
    u3 = d.where((jsonData) => jsonData["Status"] == "PENDING").toList();
    u4 = d.where((jsonData) => jsonData["Status"] == "DISPOSE OFF").toList();

    _users = [d, u1, u2, u3, u4];
  }

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

  void updateList1(var value) {
    d = _u1;
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
}
