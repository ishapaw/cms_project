import 'dart:async';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:cms/NavScreens/dashboard.dart';
import 'package:cms/NavScreens/bottom_nav_bar.dart';
import 'package:cms/auth/signin.dart';
import 'package:flutter/material.dart';
import 'Useful/func.dart';
import 'Useful/helper.dart';

void main() async {
  runApp(Phoenix(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.cyan),
      home: Splash(),
    ),
  ));
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool userIsLoggedIn = false;

  getLoggedInState() async {
    await HelperFunctions.getuserLoggedInSharePreference().then((value) {
      setState(() {
        userIsLoggedIn = value!;
      });
    });
  }

  String uid = "";

  @override
  void initState() {
    getLoggedInState();

    HelperFunctions.getuserSharePreference().then((value) {
      setState(() {
        uid = value.toString();
      });
    });

    Future.delayed(Duration(seconds: 2), () {
      userIsLoggedIn != null
          ? userIsLoggedIn
              ? checker(context, uid)
              : Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignIn()))
          : Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Spacer(),
                Image(
                  image: AssetImage('assets/images/harayana_police_logo.png'),
                  height: 100,
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
