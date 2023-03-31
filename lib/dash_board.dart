import 'package:flutter/material.dart';

import 'bottom_nav_bar.dart';

class Dash extends StatefulWidget {
  Widget body;
  List<dynamic> compl;
  List<dynamic> district;
  Map<String, dynamic> data = {};

  Dash(
      {Key? key,
      required this.body,
      required this.data,
      required this.compl,
      required this.district})
      : super(key: key);

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  @override
  Widget build(BuildContext context) {
    print("data ${widget.data}");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(Icons.chevron_left),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreen(
                            district: widget.district,
                            userdata: widget.data,
                            compl_data: widget.compl,
                          )));
            },
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: widget.body,
      ),
    );
  }
}
