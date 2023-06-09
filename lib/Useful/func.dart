import 'dart:convert';

import 'package:cms/Useful/color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../NavScreens/bottom_nav_bar.dart';

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
  var url = Uri.parse('https://cmsserver-tjnm.onrender.com/user/user/${uid}');
  http.Response response = await http.get(url);
  print(response.statusCode);

  if (response.statusCode == 200) {
    final _userdata = jsonDecode(response.body);

    if (_userdata["designation"] == "ADGP") {
      checker1(c, _userdata);
    } else if (_userdata["designation"] == "SP") {
      checker2(c, _userdata);
    } else if (_userdata["designation"] == "SHO") {
      checker3(c, _userdata);
    } else if (_userdata["designation"] == "DSP") {
      checker4(c, _userdata);
    } else if (_userdata["designation"] == "IO") {
      checker5(c, _userdata);
    }
  } else {
    print("problen");
  }
}

checker1(BuildContext c, Map<String, dynamic> _userdata) async {
  final _response = await http.get(
      Uri.parse('https://cmsserver-tjnm.onrender.com/complain/allcomplain'));

  final _response1 = await http
      .get(Uri.parse('https://cmsserver-tjnm.onrender.com/user/allsp'));

  final res = await http.get(
      Uri.parse('https://cmsserver-tjnm.onrender.com/category/getcategory'));

  final res1 = await http.get(
      Uri.parse('https://cmsserver-tjnm.onrender.com/district/getdistrict'));

  final res2 = await http.get(Uri.parse(
      'https://cmsserver-tjnm.onrender.com/policestation/getpolicestation'));

  var res3 = await http
      .get(Uri.parse('https://cmsserver-tjnm.onrender.com/visitor/getvisitor'));

  if (_response.statusCode == 200 &&
      _response1.statusCode == 200 &&
      res.statusCode == 200 &&
      res1.statusCode == 200 &&
      res2.statusCode == 200 &&
      res3.statusCode == 200) {
    var all_compl = json.decode(_response.body.toString());
    var all_sp = json.decode(_response1.body.toString());
    var all_pol = json.decode(res2.body.toString());
    var dis = json.decode(res1.body.toString()).toList();
    var category = json.decode(res.body.toString()).toList();
    var vis = json.decode(res3.body.toString());

    Navigator.push(
        c,
        MaterialPageRoute(
            builder: (context) => MainScreen(
                  io: [],
                  num: all_compl.length,
                  act: [],
                  pol: all_pol,
                  userdata: _userdata,
                  compl_data: all_compl,
                  sp: all_sp,
                  vis: vis,
                  category: category,
                  dis: dis,
                )));
  }
}

checker2(BuildContext c, Map<String, dynamic> _userdata) async {
  final _response = await http.get(
      Uri.parse('https://cmsserver-tjnm.onrender.com/complain/allcomplain'));

  final _response1 = await http
      .get(Uri.parse('https://cmsserver-tjnm.onrender.com/user/allsp'));

  final res2 = await http.get(Uri.parse(
      'https://cmsserver-tjnm.onrender.com/policestation/getpolicestation'));

  final res = await http.get(
      Uri.parse('https://cmsserver-tjnm.onrender.com/category/getcategory'));

  var res3 = await http
      .get(Uri.parse('https://cmsserver-tjnm.onrender.com/visitor/getvisitor'));

  if (_response.statusCode == 200 &&
      _response1.statusCode == 200 &&
      res2.statusCode == 200 &&
      res3.statusCode == 200 &&
      res.statusCode == 200) {
    var all_compl = json.decode(_response.body.toString());
    var all_sp = json.decode(_response1.body.toString());
    var all_pol = json.decode(res2.body.toString());
    var all_vis = json.decode(res3.body.toString());

    var category = json.decode(res.body.toString()).toList();

    var vis = all_vis.where((jsonData) => jsonData["markto"] == "SP").toList();

    var compl = all_compl
        .where((jsonData) =>
            jsonData["rangeDistrictName"] == _userdata["districtofc"])
        .toList();

    var pol = all_pol
        .where((jsonData) =>
            jsonData["policeStationDistrict"] == _userdata["districtofc"])
        .toList();

    var sp = all_sp
        .where(
            (jsonData) => (jsonData["policerange"] == _userdata["policerange"]))
        .toList();

    Navigator.push(
        c,
        MaterialPageRoute(
            builder: (context) => MainScreen(
                io: [],
                pol: pol,
                dis: [],
                num: all_compl.length,
                act: [],
                userdata: _userdata,
                compl_data: compl,
                sp: sp,
                vis: vis,
                category: category)));
  }
}

checker3(BuildContext c, Map<String, dynamic> _userdata) async {
  final _response = await http.get(
      Uri.parse('https://cmsserver-tjnm.onrender.com/complain/allcomplain'));

  final _response1 = await http
      .get(Uri.parse('https://cmsserver-tjnm.onrender.com/user/allsp'));

  final res = await http.get(
      Uri.parse('https://cmsserver-tjnm.onrender.com/category/getcategory'));

  final res1 = await http
      .get(Uri.parse('https://cmsserver-tjnm.onrender.com/act/getact'));

  final res2 = await http
      .get(Uri.parse('https://cmsserver-tjnm.onrender.com/user/allio'));

  final res3 = await http
      .get(Uri.parse('https://cmsserver-tjnm.onrender.com/visitor/getvisitor'));

  if (_response.statusCode == 200 &&
      _response1.statusCode == 200 &&
      res.statusCode == 200 &&
      res1.statusCode == 200 &&
      res2.statusCode == 200 &&
      res3.statusCode == 200) {
    var all_compl = json.decode(_response.body.toString());
    var all_sp = json.decode(_response1.body.toString());
    var all_io = json.decode(res2.body.toString());
    var all_vis = json.decode(res3.body.toString());

    var compl = all_compl
        .where((jsonData) =>
            jsonData["policestation"] == _userdata["policestation"])
        .toList();

    print(_userdata);

    var io = all_io
        .where((jsonData) =>
            jsonData["policestation"] == _userdata["policestation"])
        .toList();

    var sp = all_sp
        .where(
            (jsonData) => (jsonData["policerange"] == _userdata["policerange"]))
        .toList();

    var vis = [];

    vis.addAll(all_vis
        .where((jsonData) =>
            (jsonData["markto"] == "SHO") ||
            (jsonData["markto"] == _userdata["email"]))
        .toList());

    for (int i = 0; i < io.length; i++) {
      vis.addAll(
          all_vis.where((jsonData) => (jsonData["markto"] == io[i]["email"])));
    }

    print("u2=${io}");

    var category = json.decode(res.body.toString()).toList();
    var act = json.decode(res1.body.toString()).toList();

    Navigator.push(
        c,
        MaterialPageRoute(
            builder: (context) => MainScreen(
                io: io,
                num: all_compl.length,
                act: act,
                userdata: _userdata,
                compl_data: compl,
                sp: sp,
                vis: vis,
                pol: [],
                dis: [],
                category: category)));
  }
}

checker4(BuildContext c, Map<String, dynamic> _userdata) async {
  final _response = await http.get(
      Uri.parse('https://cmsserver-tjnm.onrender.com/complain/allcomplain'));

  final _response1 = await http.get(Uri.parse(
      'https://cmsserver-tjnm.onrender.com/policestation/getpolicestation'));

  final res = await http.get(
      Uri.parse('https://cmsserver-tjnm.onrender.com/category/getcategory'));

  final res1 = await http
      .get(Uri.parse('https://cmsserver-tjnm.onrender.com/act/getact'));

  final res2 = await http
      .get(Uri.parse('https://cmsserver-tjnm.onrender.com/user/allio'));

  final res3 = await http
      .get(Uri.parse('https://cmsserver-tjnm.onrender.com/visitor/getvisitor'));

  final res4 = await http
      .get(Uri.parse('https://cmsserver-tjnm.onrender.com/user/allsp'));

  if (_response.statusCode == 200 &&
      _response1.statusCode == 200 &&
      res.statusCode == 200 &&
      res1.statusCode == 200 &&
      res2.statusCode == 200 &&
      res3.statusCode == 200 &&
      res4.statusCode == 200) {
    var all_compl = json.decode(_response.body.toString());
    var all_pol = json.decode(_response1.body.toString());
    var all_io = json.decode(res2.body.toString());
    var all_vis = json.decode(res3.body.toString());
    var all_sp = json.decode(res4.body.toString());

    var compl = all_compl
        .where((jsonData) =>
            jsonData["rangeDistrictName"] == _userdata["districtofc"])
        .toList();

    var io = all_io
        .where(
            (jsonData) => jsonData["districtofc"] == _userdata["districtofc"])
        .toList();

    var pol = all_pol
        .where((jsonData) => (jsonData["policeStationDistrict"] == "JIND"))
        .toList();

    var vis =
        all_vis.where((jsonData) => (jsonData["markto"] != "SP")).toList();

    var sp = all_sp
        .where(
            (jsonData) => (jsonData["policerange"] == _userdata["policerange"]))
        .toList();

    var category = json.decode(res.body.toString()).toList();
    var act = json.decode(res1.body.toString()).toList();

    Navigator.push(
        c,
        MaterialPageRoute(
            builder: (context) => MainScreen(
                io: io,
                num: all_compl.length,
                act: act,
                userdata: _userdata,
                compl_data: compl,
                pol: pol,
                dis: [],
                sp: sp,
                vis: vis,
                category: category)));
  }
}

checker5(BuildContext c, Map<String, dynamic> _userdata) async {
  final _response = await http.get(
      Uri.parse('https://cmsserver-tjnm.onrender.com/complain/allcomplain'));

  final res = await http.get(
      Uri.parse('https://cmsserver-tjnm.onrender.com/category/getcategory'));

  final res1 = await http
      .get(Uri.parse('https://cmsserver-tjnm.onrender.com/act/getact'));

  if (_response.statusCode == 200 &&
      res.statusCode == 200 &&
      res1.statusCode == 200) {
    var all_compl = json.decode(_response.body.toString());

    var compl = all_compl
        .where((jsonData) => jsonData["Markto"] == _userdata["email"])
        .toList();

    print(_userdata);

    var category = json.decode(res.body.toString()).toList();
    var act = json.decode(res1.body.toString()).toList();

    Navigator.push(
        c,
        MaterialPageRoute(
            builder: (context) => MainScreen(
                io: [],
                num: all_compl.length,
                act: act,
                userdata: _userdata,
                compl_data: compl,
                sp: [],
                vis: [],
                pol: [],
                dis: [],
                category: category)));
  }
}
