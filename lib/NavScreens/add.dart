import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import 'package:cms/Useful/color.dart';
import 'package:cms/Useful/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../Useful/func.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class AddScreen extends StatefulWidget {
  List<dynamic> sp, category, act, io, compl;
  Map<String, dynamic> userdata;
  int num;
  String range;
  AddScreen(
      {Key? key,
      required this.compl,
      required this.io,
      required this.userdata,
      required this.num,
      required this.act,
      required this.sp,
      required this.range,
      required this.category})
      : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController name_controller = TextEditingController();
  TextEditingController diary_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController alt_controller = TextEditingController();
  TextEditingController addr_controller = TextEditingController();
  TextEditingController fat_controller = TextEditingController();
  TextEditingController desc_controller = TextEditingController();
  TextEditingController sec_controller = TextEditingController();
  TextEditingController addr1_controller = TextEditingController();
  TextEditingController city_controller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String event_date = "Select date";
  DateTime date = DateTime.now();
  String selectedCategory = "",
      selectedCategory1 = "",
      selectedCategory2 = "",
      selectedCategory3 = "",
      selectedCategory4 = "",
      selectedCategory41 = "",
      selectedCategory5 = "";

  bool isHide = false;

  String mark_to = "";

  int index = 0, index1 = 0;

  bool hp = false;

  List<DropdownMenuItem<String>> dropDownItems1 = [],
      dropDownItems = [],
      dropDownItems2 = [],
      dropDownItems3 = [],
      dropDownItems4 = [],
      dropDownItems5 = [];

  List<String> status = ["PENDING", "IN-PROCESS", "DISPOSE OFF"],
      high = ["Select", "Home Minister", "NHRC", "DG Office"];

  getStatus() {
    for (int i = 0; i < status.length; i++) {
      String cat = status[i];
      print(cat);
      var newItem = DropdownMenuItem(
        child: Text(cat),
        value: cat,
      );
      dropDownItems2.add(newItem);
    }
  }

  getHP() {
    for (int i = 0; i < high.length; i++) {
      String cat = high[i];
      print(cat);
      var newItem = DropdownMenuItem(
        child: Text(cat),
        value: cat,
      );
      dropDownItems5.add(newItem);
    }
  }

  Map m = {};

  getMarkTo() {
    for (int i = 0; i < widget.io.length; i++) {
      m[widget.io[i]["email"]] = widget.io[i]["fname"] +
          " " +
          widget.io[i]["lname"] +
          " " +
          "- " +
          widget.compl
              .where((jsonData) =>
                  jsonData["Markto"] == widget.io[i]["email"].toLowerCase())
              .toList()
              .length
              .toString();
    }
  }

  getIO() {
    for (int i = 0; i < widget.io.length; i++) {
      String cat = widget.io[i]["fname"] +
          " " +
          widget.io[i]["lname"] +
          " (" +
          widget.io[i]["email"].toLowerCase().toString() +
          ") " +
          "- " +
          widget.compl
              .where((jsonData) =>
                  jsonData["Markto"] == widget.io[i]["email"].toLowerCase())
              .toList()
              .length
              .toString();
      var newItem = DropdownMenuItem(
        child: Text(cat),
        value: cat,
      );
      dropDownItems4.add(newItem);
    }
  }

  getAct() {
    var firstItem = DropdownMenuItem(
      child: Text("Select Complaint Action"),
      value: "Select Complaint Action",
    );
    dropDownItems3.add(firstItem);

    for (int i = 0; i < widget.act.length; i++) {
      if (widget.act[i]["actName"].length != 0) {
        String cat = widget.act[i]["actName"][0];
        var newItem = DropdownMenuItem(
          child: Text(cat),
          value: cat,
        );
        dropDownItems3.add(newItem);
      }
    }
  }

  getCategory() {
    var firstItem = DropdownMenuItem(
      child: Text("Select Category"),
      value: "Select Category",
    );
    dropDownItems.add(firstItem);

    for (int i = 0; i < widget.category.length; i++) {
      String cat = widget.category[i]["categoryName"];

      var newItem = DropdownMenuItem(
        child: Text(cat),
        value: cat,
      );
      dropDownItems.add(newItem);
    }
  }

  @override
  void initState() {
    selectedCategory = "Select Category";
    selectedCategory1 = "HANSI";
    selectedCategory2 = "PENDING";
    selectedCategory3 = "Select Complaint Action";
    selectedCategory4 = widget.io.length > 0
        ? widget.io[0]["fname"] +
            " " +
            widget.io[0]["lname"] +
            " (" +
            widget.io[0]["email"].toLowerCase().toString() +
            ") " +
            "- " +
            widget.compl
                .where(
                    (jsonData) => jsonData["Markto"] == widget.io[0]["email"])
                .toList()
                .length
                .toString()
        : "null";
    selectedCategory41 = widget.io[0]["email"];
    selectedCategory5 = "Select";

    getCategory();
    getStatus();
    getAct();
    getHP();
    getIO();
    getMarkTo();
    super.initState();
  }

  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  var targetDate;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: _messangerKey,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Stack(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Complaint',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 23),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Diary Number-",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          height: 65,
                          width: MediaQuery.of(context).size.width / 2,
                          child: TextFormField(
                            maxLength: 18,
                            cursorColor: Colors.black,
                            controller: diary_controller,
                            enableSuggestions: false,
                            autocorrect: false,
                            style: TextStyle(
                              fontFamily: 'mons',
                              fontSize: 13.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              helperText: " ",
                              counterText: "",
                              fillColor: lightBlue,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none)),
                            ),
                            onChanged: (text) {
                              // password = text;
                            },
                            // validator: (value) {
                            //   if (value!.isEmpty ||
                            //       RegExp(r'^[0-9] + $').hasMatch(value!)) {
                            //     return ("Please enter correct diary no.");
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Complainant Name-",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 65,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        maxLength: 18,
                        cursorColor: Colors.black,
                        controller: name_controller,
                        enableSuggestions: false,
                        autocorrect: false,
                        style: TextStyle(
                          fontFamily: 'mons',
                          fontSize: 13.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          helperText: " ",
                          fillColor: lightBlue,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none)),
                        ),
                        onChanged: (text) {
                          // password = text;
                        },
                        validator: (value) {
                          if (value!.isEmpty ||
                              RegExp(r'^[a-z A-Z] + $').hasMatch(value!)) {
                            return ("Please enter the name");
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Father's Name-",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 65,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        maxLength: 18,
                        cursorColor: Colors.black,
                        controller: fat_controller,
                        enableSuggestions: false,
                        autocorrect: false,
                        style: TextStyle(
                          fontFamily: 'mons',
                          fontSize: 13.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          helperText: " ",
                          fillColor: lightBlue,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none)),
                        ),
                        onChanged: (text) {
                          // password = text;
                        },
                        validator: (value) {
                          if (value!.isEmpty ||
                              RegExp(r'^[a-z A-Z] + $').hasMatch(value!)) {
                            return ("Please enter the Father's name");
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Date of Upload-",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 20,
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
                            event_date = DateFormat('yyyy-MM-d').format(date);
                            targetDate = DateFormat('yyyy-MM-d')
                                .format(date.add(Duration(days: 30)));

                            print(event_date);
                            print(targetDate);
                          });
                        }, darkBlue, lightBlue)
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Phone Number-",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 65,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        maxLength: 18,
                        cursorColor: Colors.black,
                        controller: phone_controller,
                        enableSuggestions: false,
                        autocorrect: false,
                        style: TextStyle(
                          fontFamily: 'mons',
                          fontSize: 13.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          helperText: " ",
                          fillColor: lightBlue,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none)),
                        ),
                        onChanged: (text) {
                          // password = text;
                        },
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return ("Please enter a password");
                        //   } else if (value.length < 6) {
                        //     return ("The Password length must be more than 6 characters");
                        //   }
                        // },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Alternate Number-",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 65,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        maxLength: 18,
                        cursorColor: Colors.black,
                        controller: alt_controller,
                        enableSuggestions: false,
                        autocorrect: false,
                        style: TextStyle(
                          fontFamily: 'mons',
                          fontSize: 13.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          helperText: " ",
                          fillColor: lightBlue,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none)),
                        ),
                        onChanged: (text) {
                          // password = text;
                        },
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return ("Please enter a password");
                        //   } else if (value.length < 6) {
                        //     return ("The Password length must be more than 6 characters");
                        //   }
                        // },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Mark to-",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: lightBlue,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                        iconEnabledColor: darkBlue,
                        dropdownColor: lightBlue,
                        style: TextStyle(
                            color: darkBlue,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                        value: selectedCategory4,
                        items: dropDownItems4,
                        onChanged: (value) {
                          setState(() {
                            selectedCategory4 = value as String;
                            print(selectedCategory4);

                            selectedCategory41 = value.substring(
                                    value.indexOf("(") + 1, value.indexOf(")"))
                                as String;

                            print(
                                "selected: ${selectedCategory4}+   ${selectedCategory41}");
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    if (widget.userdata["designation"] == "SHO")
                      Row(
                        children: [
                          Text(
                            "SP -",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: lightBlue,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Text(
                              widget.sp[0]["fname"],
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    if (widget.userdata["designation"] == "SHO")
                      SizedBox(
                        height: 30,
                      ),
                    Text(
                      "Village/Area-",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 65,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        maxLength: 18,
                        cursorColor: Colors.black,
                        controller: city_controller,
                        enableSuggestions: false,
                        autocorrect: false,
                        style: TextStyle(
                          fontFamily: 'mons',
                          fontSize: 13.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          helperText: " ",
                          fillColor: lightBlue,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none)),
                        ),
                        onChanged: (text) {
                          // password = text;
                        },
                        validator: (value) {
                          if (value!.isEmpty ||
                              RegExp(r'^[a-z A-Z] + $').hasMatch(value!)) {
                            return ("Please enter the village/area");
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "District-",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: lightBlue,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Text(
                            widget.userdata["districtofc"],
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "Range-",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: lightBlue,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Text(
                            widget.range,
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "High Priority-",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: lightBlue,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            iconEnabledColor: darkBlue,
                            dropdownColor: lightBlue,
                            style: TextStyle(
                                color: darkBlue,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                            value: selectedCategory5,
                            items: dropDownItems5,
                            onChanged: (value) {
                              setState(() {
                                selectedCategory5 = value as String;
                                print(selectedCategory5);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "Status-",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: lightBlue,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            iconEnabledColor: darkBlue,
                            dropdownColor: lightBlue,
                            style: TextStyle(
                                color: darkBlue,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                            value: selectedCategory2,
                            items: dropDownItems2,
                            onChanged: (value) {
                              setState(() {
                                selectedCategory2 = value as String;
                                print(selectedCategory2);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Complaint Category-",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: lightBlue,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                        iconEnabledColor: darkBlue,
                        dropdownColor: lightBlue,
                        style: TextStyle(
                            color: darkBlue,
                            fontSize: 9,
                            fontWeight: FontWeight.w600),
                        value: selectedCategory,
                        items: dropDownItems,
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value as String;
                            print(selectedCategory);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Complaint Action-",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: lightBlue,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                        iconEnabledColor: darkBlue,
                        dropdownColor: lightBlue,
                        style: TextStyle(
                            color: darkBlue,
                            fontSize: 9,
                            fontWeight: FontWeight.w600),
                        value: selectedCategory3,
                        items: dropDownItems3,
                        onChanged: (value) {
                          setState(() {
                            selectedCategory3 = value as String;
                            print(selectedCategory3);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Section-",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        maxLength: 18,
                        cursorColor: Colors.black,
                        controller: sec_controller,
                        enableSuggestions: false,
                        autocorrect: false,
                        style: TextStyle(
                          fontFamily: 'mons',
                          fontSize: 13.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          fillColor: lightBlue,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none)),
                        ),
                        onChanged: (text) {
                          // password = text;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Address-",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        maxLines: 3,
                        cursorColor: Colors.black,
                        controller: addr_controller,
                        enableSuggestions: false,
                        autocorrect: false,
                        style: TextStyle(
                          fontFamily: 'mons',
                          fontSize: 13.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          fillColor: lightBlue,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none)),
                        ),
                        onChanged: (text) {
                          // password = text;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please enter the address");
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "email-",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 65,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        maxLength: 18,
                        cursorColor: Colors.black,
                        controller: email_controller,
                        enableSuggestions: false,
                        autocorrect: false,
                        style: TextStyle(
                          fontFamily: 'mons',
                          fontSize: 13.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          fillColor: lightBlue,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none)),
                        ),
                        onChanged: (text) {
                          // password = text;
                        },
                        validator: (value) {
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!);
                          if (value.isNotEmpty && !emailValid) {
                            return ("Please enter a valid email");
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Complaint's Short Description-",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        maxLines: 6,
                        cursorColor: Colors.black,
                        controller: desc_controller,
                        enableSuggestions: false,
                        autocorrect: false,
                        style: TextStyle(
                          fontFamily: 'mons',
                          fontSize: 13.0,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          fillColor: lightBlue,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none)),
                        ),
                        onChanged: (text) {
                          // password = text;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please describe the complaint");
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        borderbtnsss("Add", () {
                          if (selectedCategory == "Select Category") {
                            Snacker(
                                "Please select the category", _messangerKey);
                          } else if (formKey.currentState!.validate()) {
                            setState(() {
                              isHide = true;
                            });
                            addComplain();
                          } else {
                            Snacker("Please enter the necessary details",
                                _messangerKey);
                          }
                        }, lightBlue, darkBlue)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          loaderss(isHide, context)
        ]),
      ),
    );
  }

  var now = DateTime.now();
  var formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  addComplain() async {
    var response = await http.post(
        Uri.parse('https://cmsserver-tjnm.onrender.com/complain/create'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          "author_id": widget.userdata["_id"],
          "policerange": widget.range,
          "rangeDistrictName": widget.userdata['districtofc'],
          "policestation": widget.userdata["policestation"],
          "phoneNumber": widget.userdata['mobile'],
          "ComplainantName": name_controller.text,
          "ComplainantPhoneNumber": phone_controller.text,
          "alternateNumber": alt_controller.text,
          "FatherName": fat_controller.text,
          "Address": addr_controller.text,
          "Email": email_controller.text,
          "State": "HARYANA",
          "City": city_controller.text,
          "ComplaintCategory": selectedCategory,
          "ComplaintShortDescription": desc_controller.text,
          "SectionsofComplaint": sec_controller.text,
          "Range": widget.range,
          "SPName": widget.userdata["spname"],
          "Status": selectedCategory2,
          "Markto": selectedCategory41,
          "trackingId": widget.num + 1,
          "complainDate": event_date,
          "targetDate": targetDate,
          "highPriority": selectedCategory5 == "Select" ? false : true,
          "priorityTag": selectedCategory5.toLowerCase().replaceAll(' ', ''),
          "Dairy_no": diary_controller.text,
          "act": selectedCategory3
          // "uploadevidence": http.ByteStream(file.openRead()).cast()
        }));

    diary_controller.clear();
    city_controller.clear();
    name_controller.clear();
    email_controller.clear();
    phone_controller.clear();
    alt_controller.clear();
    addr_controller.clear();
    fat_controller.clear();
    desc_controller.clear();
    sec_controller.clear();
    event_date = "Select date";
    hp = false;

    selectedCategory = "Select Category";
    selectedCategory1 = "HANSI";
    selectedCategory2 = "PENDING";
    selectedCategory3 = "Select Complaint Action";
    selectedCategory4 = widget.io[0]["fname"] +
        " " +
        widget.io[0]["lname"] +
        " (" +
        widget.io[0]["email"] +
        ") " +
        "- " +
        widget.compl
            .where((jsonData) => jsonData["Markto"] == widget.io[0]["email"])
            .toList()
            .length
            .toString();

    print("hua ki nhi ${response.statusCode}");

    if (response.statusCode == 200) {
      Snacker("Complaint Added Successfully, reloading the app", _messangerKey);
      setState(() {
        isHide = false;
      });

      Future.delayed(Duration(seconds: 2), () {
        Phoenix.rebirth(context);
      });
    }
  }
}
