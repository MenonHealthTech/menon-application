import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:footer/footer.dart';
import 'package:menon/constants/app_colors.dart';
import 'package:menon/screens/Navigation_drawer/navbar_item.dart';
import 'package:menon/screens/Navigation_drawer/navigation_drawer_header.dart';


import 'package:navigating_drawer/navigating_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'DoctorHomePage.dart';

class DoctorHome extends StatefulWidget {
  final String phone;
  DoctorHome(this.phone);
  @override
  _DoctorHomeState createState() => _DoctorHomeState(phone);
}

class _DoctorHomeState extends State<DoctorHome> {
  final String phone; // Note: Here phone means email.
  _DoctorHomeState(this.phone);
  int i = 0;
  List<Widget> fragment = [];

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  @override
  void initState() {

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showMessage("Notification", "$message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        showMessage("Notification", "$message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        showMessage("Notification", "$message");
      },
    );


    super.initState();
  }

  showMessage(title, description) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(title),
            content: Text(description.toString()),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text("Dismiss"),
              )
            ],
          );
        });
  }



  @override
  Widget build(BuildContext context) {
    fragment = [
      DoctorHomePage(phone),
     // PatientList(phone),
      // Reports(phone),
      // Scheduler(phone),
      // Prescription(phone),
      //PaymentList(phone),
      //CovidKITMobile(),
      //Chat(phone),
      //ContactUs(),
      //addOtherReports(phone)
      // RequestList(phone),

    ];
    getDoc();
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
        actions: [
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
  void getDoc()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("DocPhone",phone);
  }
}

class NavigationDrawer extends StatelessWidget {
  final Function onTap;
  final String phone;

  NavigationDrawer({this.onTap, this.phone});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
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
              Icons.chat,
              size: 30,
            ),
            onTap: () => onTap(context, 0),
          ),
          // ListTile(
          //   title: NavBarItem("My Patients"),
          //   leading: Icon(
          //     Icons.chat,
          //     size: 30,
          //   ),
          //   onTap: () => onTap(context, 1),
          // ),
          // ListTile(
          //   title: NavBarItem("Reports"),
          //   leading: Icon(
          //     Icons.chat,
          //     size: 30,
          //   ),
          //   onTap: () => onTap(context, 1),
          // ),
          // ListTile(
          //   title: NavBarItem("Scheduler"),
          //   leading: Icon(
          //     Icons.chat,
          //     size: 30,
          //   ),
          //   onTap: () => onTap(context, 1),
          // ),
          ListTile(
            title: NavBarItem("Other Report"),
            leading: Icon(
              Icons.chat,
              size: 30,
            ),
            onTap: () => onTap(context, 1),
          ),
          ListTile(
            title: NavBarItem("Transaction"),
            leading: Icon(
              Icons.how_to_reg,
              size: 30,
            ),
            onTap: () => onTap(context, 3),
          ),
          ListTile(
            title: NavBarItem("Place Order"),
            leading: Icon(
              Icons.chat,
              size: 30,
            ),
            onTap: () => onTap(context, 4),
          ),
          ListTile(
            title: NavBarItem("Chat"),
            leading: Icon(
              Icons.chat,
              size: 30,
            ),
            onTap: () => onTap(context, 4),
          ),
          ListTile(
            title: NavBarItem("Contact Us"),
            leading: Icon(
              Icons.contact_phone,
              size: 30,
            ),
            onTap: () => onTap(context, 5),
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
    );
  }
}
