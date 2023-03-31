import 'dart:convert';

import 'package:cms/NavScreens/all.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import '../Useful/color.dart';
import '../Useful/widgets.dart';
import 'comment.dart';

class View extends StatefulWidget {
  int current;
  Map<String, dynamic> d;
  bool isAll;

  View({Key? key, required this.d, required this.current, required this.isAll})
      : super(key: key);

  @override
  State<View> createState() => _ViewState();
}

class _ViewState extends State<View> {
  @override
  Widget build(BuildContext context) {
    print(widget.d);

    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: widget.isAll ? Colors.white : Colors.black),
        title: Text(
          "View Complain",
          style: TextStyle(
              color: widget.isAll ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20),
        ),
        elevation: 0,
        backgroundColor: widget.isAll ? darkBlue : Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isAll)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Details -',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black, width: 2, style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Complainant Number-",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.d["trackingId"] != null
                                ? widget.d["trackingId"]
                                : "null",
                            style: TextStyle(
                                fontSize: 15,
                                color: darkBlue,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            "Complainant Name-",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.d["ComplainantName"] != null
                                ? widget.d["ComplainantName"]
                                : 'null',
                            style: TextStyle(
                                color: darkBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            "Date of Upload-",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.d["complainDate"] != null
                                ? widget.d["complainDate"]
                                : "null",
                            style: TextStyle(
                                color: darkBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            "Phone Number-",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.d["ComplainantPhoneNumber"].toString() !=
                                    null
                                ? widget.d["ComplainantPhoneNumber"].toString()
                                : "null",
                            style: TextStyle(
                                color: darkBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            "District-",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.d["rangeDistrictName"] != null
                                ? widget.d["rangeDistrictName"]
                                : "null",
                            style: TextStyle(
                                color: darkBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            "Complain Category-",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.d["ComplaintCategory"] != null
                                ? widget.d["ComplaintCategory"]
                                : "null",
                            style: TextStyle(
                                color: darkBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            "Father's Name-",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.d["FatherName"] != null
                                ? widget.d["FatherName"]
                                : "null",
                            style: TextStyle(
                                color: darkBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            "Address-",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.d["Address"] != null
                                ? widget.d["Address"]
                                : "null",
                            style: TextStyle(
                                color: darkBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            "email-",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.d["Email"] != null
                                ? widget.d["Email"]
                                : "null",
                            style: TextStyle(
                                color: darkBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            "police station-",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.d["policestation"] != null
                                ? widget.d["policestation"]
                                : "null",
                            style: TextStyle(
                                color: darkBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Complain Short Description-",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.d["ComplaintShortDescription"] != null
                            ? widget.d["ComplaintShortDescription"]
                            : "null",
                        style: TextStyle(
                            color: darkBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  borderbtnsss("Download", () {}, lightBlue, darkBlue)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  borderbtnsss("Add Comment", () async {
                    var comment_res = await http.get(Uri.parse(
                        'https://haryanacms.onrender.com/comment/getcomment'));
                    var c, com;
                    print(comment_res.statusCode);

                    if (comment_res.statusCode == 200) {
                      c = json.decode(comment_res.body.toString());

                      com = c.where((jsonData) =>
                          jsonData['complain_id'] == widget.d["_id"]);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewComment(
                                    comments: c,
                                  )));
                    }
                  }, lightBlue, darkBlue)
                ],
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
