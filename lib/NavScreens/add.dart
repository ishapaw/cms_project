import 'dart:convert';

import 'package:cms/NavScreens/profile.dart';
import 'package:cms/NavScreens/today.dart';
import 'package:cms/Useful/color.dart';
import 'package:cms/Useful/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cms/date.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../Useful/helper.dart';
import '../auth/signin.dart';
import 'all.dart';
import 'dashboard.dart';

class AddScreen extends StatefulWidget {
  List<dynamic> district;
  AddScreen({Key? key, required this.district}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController name_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController alt_controller = TextEditingController();
  TextEditingController addr_controller = TextEditingController();
  TextEditingController fat_controller = TextEditingController();
  TextEditingController desc_controller = TextEditingController();

  String event_date = "Select date";
  DateTime? date;
  String selectedCategory = "CAW";
  String selectedCategory1 = "HANSI";

  List<DropdownMenuItem<String>> dropDownItems1 = [];

  getDistrict() {
    for (int i = 0; i < widget.district.length; i++) {
      String cat = widget.district[i]["rangeDistrictName"];
      print(cat);
      var newItem = DropdownMenuItem(
        child: Text(cat),
        value: cat,
      );
      dropDownItems1.add(newItem);
    }
  }

  List<String> categoryList = ['CAW'];

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
    getDistrict();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Complain',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Complainant Number-",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "DSBH131044",
                    style:
                        TextStyle(color: darkBlue, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Complainant Name-",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
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
                  controller: name_controller,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: TextStyle(
                    fontFamily: 'mons',
                    fontSize: 15.0,
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
              Row(
                children: [
                  Text(
                    "Date of Upload-",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
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
                      event_date = DateFormat('d MMM yyyy').format(date!);
                      // super.setState(() {});
                    });
                  }, darkBlue, lightBlue)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Phone Number-",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
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
                  controller: phone_controller,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: TextStyle(
                    fontFamily: 'mons',
                    fontSize: 15.0,
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
                height: 20,
              ),
              Text(
                "Alternate Number-",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
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
                  controller: alt_controller,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: TextStyle(
                    fontFamily: 'mons',
                    fontSize: 15.0,
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
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "District-",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
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
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                      value: selectedCategory1,
                      items: dropDownItems1,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory1 = value as String;
                          // for (int i = 0; i < categoryList1.length; i++) {
                          //   if (selectedCategory1 == categoryList1[i]) {
                          //     index = i;
                          //   }
                          // }
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Complaint Category-",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
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
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                      value: selectedCategory,
                      items: getDropDownItems(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value as String;
                          // for (int i = 0; i < categoryList1.length; i++) {
                          //   if (selectedCategory1 == categoryList1[i]) {
                          //     index = i;
                          //   }
                          // }
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Father's Name-",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
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
                  controller: fat_controller,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: TextStyle(
                    fontFamily: 'mons',
                    fontSize: 15.0,
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
                height: 20,
              ),
              Text(
                "Address-",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  maxLines: 3,
                  cursorColor: Colors.black,
                  controller: addr_controller,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: TextStyle(
                    fontFamily: 'mons',
                    fontSize: 15.0,
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
                height: 20,
              ),
              Text(
                "email-",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
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
                  controller: email_controller,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: TextStyle(
                    fontFamily: 'mons',
                    fontSize: 15.0,
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
                height: 20,
              ),
              Text(
                "Complaint Short Description-",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
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
                    fontSize: 15.0,
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
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return ("Please enter a password");
                  //   } else if (value.length < 6) {
                  //     return ("The Password length must be more than 6 characters");
                  //   }
                  // },
                ),
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  borderbtnsss("Add", () {}, lightBlue, darkBlue)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
