import 'package:cms/IO/screen.dart';
import 'package:flutter/material.dart';

import 'color.dart';

Widget card(BuildContext context, int count, String text) {
  return Container(
    height: 100,
    width: MediaQuery.of(context).size.width / 2.45,
    decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage("assets/images/rect2.png"))),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${count}",
            style: TextStyle(
                fontSize: 33, color: darkBlue, fontWeight: FontWeight.w700),
          ),
          // SizedBox(
          //   height: 1,
          // ),
          Text(
            text,
            style: TextStyle(
                fontSize: 13, color: darkBlue, fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
  );
}

Widget ver_card(BuildContext context, int count, String name) {
  return Container(
    height: 180,
    width: 130,
    decoration: BoxDecoration(
      boxShadow: kElevationToShadow[3],
      color: lightBlue,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            image: AssetImage("assets/images/harayana_police_logo.png"),
            height: 70,
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            name,
            style: TextStyle(
                fontSize: 15, color: darkBlue, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            "complaints- ${count}",
            style: TextStyle(
                fontSize: 13, color: darkBlue, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    ),
  );
}

Widget listTile(String text, IconData? icon) {
  return ListTile(
    visualDensity: VisualDensity(horizontal: 0, vertical: -3),
    leading: IconButton(
      icon: Icon(icon),
      color: darkBlue,
      onPressed: () {},
    ),
    title: Text(
      text,
      style: TextStyle(fontSize: 16, color: Colors.black),
    ),
  );
}
