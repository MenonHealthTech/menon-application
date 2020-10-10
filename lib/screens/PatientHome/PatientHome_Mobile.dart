import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:menon/constants/app_colors.dart';
import 'package:menon/screens/DoctorsList/DoctorsList.dart';
import 'package:menon/screens/MyDoctor/MyDoctor.dart';
import 'package:menon/screens/Navigation_drawer/navbar_item.dart';
import 'package:menon/screens/Navigation_drawer/navigation_drawer_header.dart';
import 'package:menon/screens/otherReports/displayOtherReport.dart';
import 'package:menon/screens/otherReports/patientOtherReports.dart';

import 'package:url_launcher/url_launcher.dart';
import 'PatientHomePage.dart';

class PatientHome extends StatefulWidget {
  final String phone;

  PatientHome(this.phone);

  @override
  _PatientHomeState createState() => _PatientHomeState(phone);
}

class _PatientHomeState extends State<PatientHome> {
  final String phone;

  _PatientHomeState(this.phone);

  int i = 3;
  List<Widget> fragment = [];

  @override
  Widget build(BuildContext context) {
    fragment = [
      PatientHomePage(phone),
      // HealthDataMobileWeb(phone),
      // ReportList(phone),
      MyDoctor(phone),
      addOtherReports(phone),
      displayOther(phone),
      DoctordList(phone),
      //addOtherReports(phone),
      // // Appointment(phone),
      // readPrescription(phone),
      // // transactions(phone),
      // CovidKITMobile(),
      // EmergencyContact(),
      // ContactUs(),
      // DoctorPaymentList(phone),
    ];
    //getNotify();
    //print("Ap here");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menon Health Tech",
          style: TextStyle(color: primaryColor),
        ),
        iconTheme: IconThemeData(color: primaryColor),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 5.0,
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Stack(
                  children: <Widget>[
                    Icon(
                      Icons.notifications,
                      color: primaryColor,
                      size: 35.0,
                    ),
                    // if(stat == true)
                    //   Positioned(child: Icon(Icons.brightness_1,color: Colors.red,size: 12.0))
                    // else
                    //   Positioned(child: Icon(Icons.brightness_1,color: Colors.white,size: 9.0))
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
                child: Image(
                    image: AssetImage('Images/appbar.png'),
                    height: 50,
                    width: 50)),
          ),
        ],
      ),
      drawer: NavigationDrawer(
          phone: phone,
          onTap: (context, index) {
            Navigator.pop(context);
            setState(() {
              i = index;
            });
          }),
      body: fragment[i],
    );
  }

  Future getNotify() async {
    print("getNotify cals");
    //   stat = await DB().notification(phone);
    // if(stat == null)
    // return Loading();
  }
}

class NavigationDrawer extends StatelessWidget {
  final Function onTap;
  final String phone;

  NavigationDrawer({this.onTap, this.phone});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 300,
        height: 850,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 16),
          ],
        ),
        child: Column(
          children: <Widget>[
            NavigationDrawerHeader(phone),
            ListTile(
              title: NavBarItem("Home Page"),
              leading: Icon(
                Icons.format_align_center,
                size: 30,
              ),
              onTap: () => onTap(context, 0),
            ),
            ListTile(
              title: NavBarItem("Data Entry"),
              leading: Icon(
                Icons.format_align_center,
                size: 30,
              ),
              onTap: () => onTap(context, 1),
            ),
            ListTile(
              title: NavBarItem("Reports"),
              leading: Icon(
                Icons.timeline,
                size: 30,
              ),
              onTap: () => onTap(context, 3),
            ),
            ListTile(
              title: NavBarItem("My Doctor"),
              leading: Icon(
                Icons.person,
                size: 30,
              ),
              onTap: () => onTap(context,
                  1), //** its 1 for temp but will change to 3 after add all items to navigation.**//
            ),
            ListTile(
              title: NavBarItem("Doctors Panel"),
              leading: Icon(
                Icons.local_hospital_sharp,
                size: 30,
              ),
              onTap: () => onTap(context, 4),
            ),
            ListTile(
              title: NavBarItem("Other Reports"),
              leading: Icon(
                Icons.timeline_outlined,
                size: 30,
              ),
              onTap: () => onTap(context, 2),
            ),
            // ListTile(
            //   title: NavBarItem("Transaction"),
            //   leading: Icon(
            //     Icons.person,
            //     size: 30,
            //   ),
            //   onTap: () => onTap(context, 7),
            // ),
            ListTile(
              title: NavBarItem("Place Order"),
              leading: Icon(
                Icons.question_answer,
                size: 30,
              ),
              onTap: () => onTap(context, 6),
            ),
            ListTile(
              title: NavBarItem("Emergency Contact"),
              leading: Icon(
                Icons.help_center,
                size: 30,
              ),
              onTap: () => onTap(context, 7),
            ),
            ListTile(
              title: NavBarItem("Contact Us"),
              leading: Icon(
                Icons.contact_phone,
                size: 30,
              ),
              onTap: () => onTap(context, 8),
            ),
            Footer(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                child: Text(
                  "Disclaimer",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.grey,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                onTap: () async {
                  if (await canLaunch(
                      "https://drive.google.com/file/d/1Q9S_a1l-KaKXW-3wlkSbq6NBrh6i24yg/view?usp=sharing")) {
                    await launch(
                        "https://drive.google.com/file/d/1Q9S_a1l-KaKXW-3wlkSbq6NBrh6i24yg/view?usp=sharing");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
