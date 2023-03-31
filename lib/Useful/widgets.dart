import 'package:cms/IO/screen.dart';
import 'package:flutter/material.dart';

import '../IO/screen2.dart';
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

Widget ver_card(BuildContext context, int count, String name, String mark_to,
    List<dynamic> compl) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => IOScreen(
                    compl: compl,
                    officer: name,
                    mark_to: mark_to,
                  )));
    },
    child: Container(
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
    ),
  );
}

Widget listTile(String text, IconData? icon, void Function()? func) {
  return ListTile(
    visualDensity: VisualDensity(horizontal: 0, vertical: -3),
    leading: IconButton(
      icon: Icon(icon),
      color: darkBlue,
      onPressed: func,
    ),
    title: Text(
      text,
      style: TextStyle(fontSize: 15, color: Colors.black),
    ),
  );
}

Widget scroll(int count, String text, Color bg, Color t, int s) {
  return AnimatedContainer(
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
      boxShadow: kElevationToShadow[s],
      color: t,
      borderRadius: BorderRadius.circular(16),
    ),
    duration: Duration(milliseconds: 300),
    child: Row(
      children: [
        Text(
          "${text}  ${count}",
          style: TextStyle(color: bg, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

Widget profile(BuildContext context, String title, String ans) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          SizedBox(
            width: 30,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          SizedBox(
            width: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.25,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: bgBlue, borderRadius: BorderRadius.circular(10)),
            child: Text(
              ans,
              style: TextStyle(color: darkBlue, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      )
    ],
  );
}

class borderbtnsss extends StatelessWidget {
  VoidCallback callback;
  String title;
  Color text;
  Color bg;

  borderbtnsss(this.title, this.callback, this.text, this.bg);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
        child: Text(
          title,
          style: TextStyle(color: text, fontWeight: FontWeight.w600),
        ),
      ),
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(bg),
          backgroundColor: MaterialStateProperty.all<Color>(bg),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: bg, width: 2.0)))),
      onPressed: callback,
    );
  }
}
