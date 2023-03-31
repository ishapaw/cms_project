// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'Useful/color.dart';
// import 'Useful/func.dart';
// import 'Useful/widgets.dart';
//
// class Test extends StatefulWidget {
//   const Test({Key? key}) : super(key: key);
//
//   @override
//   State<Test> createState() => _TestState();
// }
//
// int current = 0;
// List<String> filter = ["All", "High Priority", "Pending", "Closed"];
// List<Color> color = [
//   bl,
//   Color(0xffFF0F00),
//   Color(0xffFA9718),
//   Color(0xff00BB13)
// ];
// List<int> ct = [20, 11, 8, 7];
//
// class _TestState extends State<Test> {
//   int current = 0;
//   List<String> mark_to = [
//     "satishjain",
//     "rakeshmishra",
//     "sahilsharma",
//     "rohitpawar",
//     "satishyadav",
//     "gauravpandey"
//   ];
//   List<String> name = [
//     "Satish Jain",
//     "Rakesh Mishra",
//     "Sahil Sharma",
//     "Rohit Pawar",
//     "Satish Yadav",
//     "Gaurav Pandey"
//   ];
//
//   var user, u1;
//   getNum() async {
//     print(current);
//     final response = await http
//         .get(Uri.parse('https://haryanacms.onrender.com/complain/allcomplain'));
//     print(response.statusCode);
//
//     if (response.statusCode == 200) {
//       user = json.decode(response.body.toString());
//       print(user);
//       setState(() {
//         u1 = user
//             .where((jsonData) => jsonData["Markto"] == mark_to[current])
//             .toList();
//       });
//     } else {}
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           SizedBox(
//             height: 200,
//             child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: 6,
//                     itemBuilder: (context, index) {
//                       current = index;
//                       print(current);
//                       return ver_card(context, u1 == null ? 0 : u1.length(),
//                           name[index], mark_to[index]);
//                     })),
//           ),
//         ],
//       ),
//     );
//   }
// }
