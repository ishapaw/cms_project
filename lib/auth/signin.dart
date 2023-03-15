import 'package:cms/Useful/color.dart';
import 'package:cms/auth/reset_pas.dart';
import 'package:flutter/material.dart';

import '../NavScreens/dashboard.dart';
import '../bottom_nav_bar.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
double screenh = 0;
double screenw = 0;
String email = "";
String password = "";
bool isHide = false;
bool passwordVisible = true;

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    screenh = MediaQuery.of(context).size.height;
    screenw = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/harayana_police_logo.png'),
                  height: 120,
                ),
                SizedBox(
                  height: 75,
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
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
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
                          controller: passwordController,
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
                                      ? AssetImage("assets/images/eye.png")
                                      : AssetImage("assets/images/eye1.png")),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                            labelText: "password",
                            counterText: "",
                            prefixIcon: Image(
                                image: AssetImage("assets/images/pas1.png")),
                            fillColor: greyLight,
                            filled: true,
                            labelStyle: TextStyle(color: greyMed),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none)),
                          ),
                          onChanged: (text) {
                            // password = text;
                          },
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return ("Please enter a password");
                          //   } else if (value.length < 6) {
                          //     return ("The Password length must be more than 6 characters");
                          //   }
                          // },
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainScreen()));
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(redColor),
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
                                    builder: (context) => ResetPassword()));
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: greyDark, fontSize: 15),
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
    );
  }
}
