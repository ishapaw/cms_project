import 'package:cms/NavScreens/profile.dart';
import 'package:cms/Useful/color.dart';
import 'package:cms/auth/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Useful/widgets.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            );
          },
        ),
        leadingWidth: 38,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome,",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Manish Sharma, SHO",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: darkBlue,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/harayana_police_logo.png"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Complaint Management System",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            listTile("Profile", Icons.person),
            listTile("Dashboard", Icons.dashboard),
            listTile("Add New Complaint", Icons.add_circle),
            SizedBox(
              height: 5,
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
              height: 15,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              height: 5,
            ),
            listTile("All Complaints (60)", Icons.calendar_today_rounded),
            listTile("Today's Complaints (20)", Icons.calendar_today_rounded),
            listTile("High Priority (7)", Icons.calendar_today_rounded),
            listTile("Pending Complaints (8)", Icons.calendar_today_rounded),
            listTile("Closed Complaints (10)", Icons.calendar_today_rounded),
            SizedBox(
              height: 5,
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
              height: 15,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              height: 5,
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              leading: IconButton(
                icon: Icon(Icons.logout_rounded),
                color: darkBlue,
                onPressed: () {},
              ),
              title: Text(
                "LogOut",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(15, 40, 20, 0),
          //   child: Column(
          //     children: [
          //       Row(
          //         children: [
          //           GestureDetector(
          //             onTap: () {

          //             },
          //             child: Container(
          //                 child: Image(
          //                     image: AssetImage("assets/images/drawer.png"))),
          //           ),
          //           SizedBox(
          //             width: 20,
          //           ),

          //         ],
          //       ),
          //       SizedBox(
          //         height: 5,
          //       ),
          //       Row(
          //         children: [
          //           SizedBox(
          //             width: 47,
          //           ),
          //           Text(
          //             "Manish Sharma, SHO",
          //             style: TextStyle(
          //                 color: Colors.black,
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.w500),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Spacer(),
                    card(context, 15, "Total Complaints"),
                    SizedBox(
                      width: 15,
                    ),
                    card(context, 10, "CAW Complaints"),
                    Spacer()
                  ],
                ),
                Row(
                  children: [
                    Spacer(),
                    card(context, 8, "Pending Complaints"),
                    SizedBox(
                      width: 15,
                    ),
                    card(context, 7, "Closed Complaints"),
                    Spacer()
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Investigation Officers",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Text(
                      "View All",
                      style: TextStyle(
                          fontSize: 13,
                          color: darkBlue,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        ver_card(context, 5, "Manish Sharma"),
                        SizedBox(
                          width: 20,
                        ),
                        ver_card(context, 10, "Satish Jain"),
                        SizedBox(
                          width: 20,
                        ),
                        ver_card(context, 15, "Amit Shukla")
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "High Stake Complaints",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Text(
                      "View All",
                      style: TextStyle(
                          fontSize: 13,
                          color: darkBlue,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Drawer(
//         backgroundColor: Colors.white,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//               color: darkBlue,
//               child: Center(
//                 child: Column(
//                   children: [
//                     Container(
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage(
//                               "assets/images/harayana_police_logo.png"),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       "Complaint Management System",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 17),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   GestureDetector(
//                       onTap: () {},
//                       child: Text("Profile",
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500))),
//                   SizedBox(height: 20),
//                   GestureDetector(
//                       onTap: () {},
//                       child: Text('Dashboard',
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500))),
//                   SizedBox(height: 20),
//                   GestureDetector(
//                       onTap: () {},
//                       child: Text('Add New Complaint',
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500))),
//                   SizedBox(height: 10),
//                   Divider(
//                     color: Colors.black,
//                     thickness: 1,
//                     height: 15,
//                     // indent: 5,
//                     // endIndent: 5,
//                   ),
//                   SizedBox(height: 10),
//                   GestureDetector(
//                       onTap: () {},
//                       child: Text('All Complaints  (20)',
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500))),
//                   SizedBox(height: 20),
//                   GestureDetector(
//                       onTap: () {},
//                       child: Text("Today's Complaints  (20)",
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500))),
//                   SizedBox(height: 20),
//                   GestureDetector(
//                       onTap: () {},
//                       child: Text('High Priority  (20)',
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500))),
//                   SizedBox(height: 20),
//                   GestureDetector(
//                       onTap: () {},
//                       child: Text('Pending Complaints  (20)',
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500))),
//                   SizedBox(height: 20),
//                   GestureDetector(
//                       onTap: () {},
//                       child: Text('Closed Complaints  (20)',
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500))),
//                   SizedBox(height: 10),
//                   Divider(
//                     color: Colors.black,
//                     thickness: 1,
//                     height: 15,
//                     // indent: 5,
//                     // endIndent: 5,
//                   ),
//                   SizedBox(height: 10),
//                   GestureDetector(
//                       onTap: () {},
//                       child: Text("Log Out",
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500))),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
