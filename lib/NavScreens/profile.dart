import 'package:cms/NavScreens/dashboard.dart';
import 'package:cms/NavScreens/today.dart';
import 'package:cms/Useful/widgets.dart';
import 'package:flutter/material.dart';

import '../Useful/color.dart';
import '../Useful/helper.dart';
import '../auth/signin.dart';
import 'add.dart';
import 'all.dart';

class ProfileScreen extends StatefulWidget {
  Map<String, dynamic> userdata;
  ProfileScreen({Key? key, required this.userdata}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> d = {};

  @override
  void initState() {
    d = widget.userdata;
    print(d);
  }

  @override
  Widget build(BuildContext context) {
    if (d != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
          child: Container(
            color: Colors.white,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Image(
                  image: AssetImage("assets/images/harayana_police_logo.png"),
                  height: 100,
                )),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    d["policestation"] != null ? d["policestation"] : "hello",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                profile(
                  context,
                  "Officer's Name -",
                  d["fname"] != null && d["lname"] != null
                      ? d["fname"] + " " + d["lname"]
                      : "hello",
                ),
                SizedBox(
                  height: 20,
                ),
                profile(
                  context,
                  "Designation -",
                  d["designation"] != null ? d["designation"] : "hello",
                ),
                SizedBox(
                  height: 20,
                ),
                profile(
                  context,
                  "Phone No. -",
                  d["mobile"] != null ? d["mobile"].toString() : "hello",
                ),
                SizedBox(
                  height: 20,
                ),
                profile(
                  context,
                  "Email Id -",
                  d["email"] != null ? d["email"] : "hello",
                ),
                SizedBox(
                  height: 20,
                ),
                profile(context, "Address of Police Station -", "xyz"),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        color: Colors.red,
      );
    }
  }
}
