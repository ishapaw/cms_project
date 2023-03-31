import 'dart:convert';

import 'package:cms/auth/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Useful/color.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

TextEditingController _emailController = TextEditingController();
double screenh = 0;
double screenw = 0;
String email = "";
bool isHide = false;

// Future sendEmail() async{
//   final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
//   const serviceId="service_077bman";
//   const templateId="template_73r4lj9";
//   const userId="";
//   final response = await http.post(url,headers: {'Content-Type': 'application/json'},body: json.encode({
//     "servie_id":
//   }));
// }

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    screenh = MediaQuery.of(context).size.height;
    screenw = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                      child: Icon(
                        Icons.chevron_left,
                        size: 30,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                Center(
                  child: Image(
                    image: AssetImage('assets/images/harayana_police_logo.png'),
                    height: 120,
                  ),
                ),
                SizedBox(
                  height: 95,
                ),
                Text(
                  'Reset Password',
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                Form(
                  key: RIKeys.riKey1,
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
                          controller: _emailController,
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
                      SizedBox(
                        height: 70,
                      ),
                      SizedBox(
                        width: screenw / 2,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
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
                            'Reset',
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

  // Future sendEmail({required String n}) {}
}
