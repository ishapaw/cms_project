import 'dart:convert';

import 'package:cms/Useful/color.dart';
import 'package:cms/Useful/helper.dart';
import 'package:cms/auth/reset_pas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../NavScreens/dashboard.dart';
import '../Useful/func.dart';
import '../Useful/api_serv.dart';
import '../NavScreens/bottom_nav_bar.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

double screenh = 0;
double screenw = 0;
String email = "";
String password = "";
bool isHide = false;
bool passwordVisible = true;
String uid = "";

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  callLoginApi() {
    final service = ApiServices();

    service
        .apiCallLogin(emailController.text, passController.text)
        .then((value) {
      if (value.token != null) {
        setState(() {
          isHide = true;
        });
        uid = value.uid!;

        checker(context, uid);
        HelperFunctions.saveuserLoggedInSharePreference(true);
        HelperFunctions.saveuserSharePreference(uid);
      } else {
        if (emailController.text == "" && passController.text == "") {
          setState(() {
            isHide = false;
          });
          Snacker("Please enter the email and password", _messangerKey);
        } else if (emailController.text == "") {
          setState(() {
            isHide = false;
          });
          Snacker("Please enter the email", _messangerKey);
        } else if (passController.text == "") {
          setState(() {
            isHide = false;
          });
          Snacker("Please enter the password", _messangerKey);
        } else {
          setState(() {
            isHide = false;
          });
          Snacker("User Incorrect, Check Again", _messangerKey);
        }

        //push
      }
    });
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Exit App',
              style: TextStyle(color: lightBlue),
            ),
            content: Text(
              'Do you want to exit an App?',
              style: TextStyle(color: lightBlue),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: lightBlue, // Background color
                ),
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text('No'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: lightBlue, // Background color
                ),
                onPressed: () => SystemNavigator.pop(),
                //return true when click on "Yes"
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  void initState() {
    isHide = false;
  }

  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    screenh = MediaQuery.of(context).size.height;
    screenw = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: showExitPopup,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: _messangerKey,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(children: [
            SingleChildScrollView(
              child: Stack(children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 70),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(
                              'assets/images/harayana_police_logo.png'),
                          height: 60,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 7,
                        ),
                        Text(
                          'Sign in',
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        Form(
                          key: RIKeys.riKey2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                height: 50,
                                width: screenw / 1.3,
                                child: TextFormField(
                                  controller: emailController,
                                  maxLength: 36,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: Colors.black,
                                  style: TextStyle(
                                    fontFamily: 'mons',
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "email",
                                    counterText: "",
                                    prefixIcon: Icon(
                                      Icons.mail_rounded,
                                      color: Colors.black,
                                    ),
                                    fillColor: greyLight,
                                    filled: true,
                                    labelStyle: TextStyle(color: greyMed),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            width: 0, style: BorderStyle.none)),
                                  ),
                                  onChanged: (text) {
                                    // email = text;
                                  },
                                  // validator: (value) {
                                  //   bool emailValid = RegExp(
                                  //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  //       .hasMatch(value!);
                                  //   if (!emailValid) {
                                  //     return ("Please enter a valid email");
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                ),
                              ),
                              SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                width: screenw / 1.3,
                                child: TextFormField(
                                  maxLength: 18,
                                  cursorColor: Colors.black,
                                  controller: passController,
                                  obscureText: !passwordVisible,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  style: TextStyle(
                                    fontFamily: 'mons',
                                    fontSize: 15.0,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Image(
                                          image: passwordVisible
                                              ? AssetImage(
                                                  "assets/images/eye.png")
                                              : AssetImage(
                                                  "assets/images/eye1.png")),
                                      onPressed: () {
                                        setState(() {
                                          passwordVisible = !passwordVisible;
                                        });
                                      },
                                    ),
                                    labelText: "password",
                                    counterText: "",
                                    prefixIcon: Image(
                                        image: AssetImage(
                                            "assets/images/pas1.png")),
                                    fillColor: greyLight,
                                    filled: true,
                                    labelStyle: TextStyle(color: greyMed),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            width: 0, style: BorderStyle.none)),
                                  ),
                                  onChanged: (text) {
                                    // password = text;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("Please enter a password");
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: screenh / 7,
                              ),
                              SizedBox(
                                width: screenw / 2,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // setState((){
                                    //
                                    // })
                                    callLoginApi();
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              redColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ))),
                                  child: Text(
                                    'Log In',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   height: 1,
                              // ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ResetPassword()));
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        color: greyDark, fontSize: 15),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // loaderss(isHide, context)
              ]),
            ),
            loaderss(isHide, context)
          ]),
        ),
      ),
    );
  }
}
