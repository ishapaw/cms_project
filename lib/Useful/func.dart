import 'dart:convert';

import 'package:cms/Useful/color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../bottom_nav_bar.dart';

void Snacker(String title, GlobalKey<ScaffoldMessengerState> aa) {
  final snackBar = SnackBar(
      elevation: 0,
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: darkBlue,
      content: Text(title));

  aa.currentState?.showSnackBar(snackBar);
  // messangerKey.currentState?.showSnackBar(snackBar);
}

checker(BuildContext c, String uid) async {
  var url = Uri.parse('https://hrycms.onrender.com/user/user/${uid}');
  http.Response response = await http.get(url);
  print(response.statusCode);

  var _u1, _u2, _u3;
  if (response.statusCode == 200) {
    final _userdata = jsonDecode(response.body);

    final _response = await http
        .get(Uri.parse('https://hrycms.onrender.com/complain/allcomplain'));
    final _response1 = await http
        .get(Uri.parse('https://hrycms.onrender.com/district/getDistrict'));

    if (_response.statusCode == 200 && _response1.statusCode == 200) {
      _u1 = json.decode(_response.body.toString());
      _u2 = json.decode(_response1.body.toString());
      _u3 = _u1
          .where((jsonData) =>
              jsonData["policestation"] == _userdata["policestation"])
          .toList();

      Navigator.push(
          c,
          MaterialPageRoute(
              builder: (context) => MainScreen(
                  userdata: _userdata, compl_data: _u3, district: _u2)));
    }
  } else {
    print("problen");
  }
}
