import 'dart:convert';

import 'package:cms/Useful/color.dart';
import 'package:cms/Useful/func.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'NavScreens/bottom_nav_bar.dart';

class Dash extends StatefulWidget {
  Widget body;
  List<dynamic> compl, io, act, vis, category, dis, pol;
  int num;
  List<dynamic> sp;
  Map<String, dynamic> data = {};

  Dash(
      {Key? key,
      required this.dis,
      required this.pol,
      required this.io,
      required this.vis,
      required this.category,
      required this.act,
      required this.num,
      required this.body,
      required this.data,
      required this.compl,
      required this.sp})
      : super(key: key);

  @override
  State<Dash> createState() => _DashState();
}

bool isHide = false;

class _DashState extends State<Dash> {
  bool isHide1 = false;

  @override
  void initState() {
    isHide = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(children: [
        Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
                child: Icon(Icons.chevron_left),
                onTap: () async {
                  setState(() {
                    isHide = true;
                  });

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreen(
                              dis: widget.dis,
                              pol: widget.pol,
                              io: widget.io,
                              num: widget.num,
                              act: widget.act,
                              userdata: widget.data,
                              compl_data: widget.compl,
                              sp: widget.sp,
                              vis: widget.vis,
                              category: widget.category)));
                }),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: widget.body,
        ),
      ]),
    );
  }
}
