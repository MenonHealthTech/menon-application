import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:menon/constants/app_colors.dart';
import 'package:menon/firestore/db.dart';
import 'package:menon/widgets/Loading.dart';

import 'package:url_launcher/url_launcher.dart';

class PatientHomePage extends StatefulWidget {
  final String phone;
  PatientHomePage(this.phone);
  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {

  Widget homeMyDoctor(String phone){
    return FutureBuilder(
        future: DB().getMyDoctor(widget.phone),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Loading();
          } else if (snapshot.data.length == 0) {
            return Container(
              //Give add doctor button
            );
          } else {
            return ListView.separated(
                separatorBuilder: (BuildContext context, int i) {
                  return Divider(
                    color: Colors.transparent,
                  );
                },
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10),
                    tileColor: primaryColor,
                    // leading: CircleAvatar(
                    //     backgroundImage: AssetImage("Images/doctor.png")),
                    title: Text(
                      snapshot.data[index].firstName +
                          " " +
                          snapshot.data[index].lastName,
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                    subtitle: Text(
                      snapshot.data[index].degree,
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.phone),
                      onPressed: () {
                        launch("tel:" + snapshot.data[index].phone);
                      },
                    ),
                    onTap: () {/*
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => MyDoctorProfile(
                                  widget.phone, snapshot.data[index])))
                          .then((value) {
                        setState(() {});
                      });*/
                    },
                  );
                });
          }
        });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        //TOP
        homeMyDoctor(widget.phone),
        //ROW
        //add small icon to directly open latest prescription
        //add button to order COVID KIT
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 140,
              width: 140,
              child: RaisedButton(
                color: Colors.white,
                textColor: primaryColor,
                hoverColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: primaryColor, width: 3),
                ),
                // shape: Border.all(color: primaryColor, width: 3),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Icon(FontAwesomeIcons.moneyCheck,
                          size: 50, color: primaryColor),
                      SizedBox(height: 20),
                      Text(
                        "Data Logging",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     new MaterialPageRoute(
                  //         builder: (context) =>
                  //             Requests(phone)));
                },
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Container(
              height: 140,
              width: 140,
              child: RaisedButton(
                color: Colors.white,
                textColor: primaryColor,
                hoverColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: primaryColor, width: 3),
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Icon(FontAwesomeIcons.calendarAlt,
                          size: 50, color: primaryColor),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Appointment",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     new MaterialPageRoute(
                  //         builder: (context) =>
                  //             RegisterForm(phone, _userType)));
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 140,
              width: 140,
              child: RaisedButton(
                color: Colors.white,
                textColor: primaryColor,
                hoverColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: primaryColor, width: 3),
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Icon(FontAwesomeIcons.chartLine,
                          size: 50, color: primaryColor),
                      SizedBox(height: 20),
                      Text(
                        "Reports",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     new MaterialPageRoute(
                  //         builder: (context) =>
                  //             Requests(phone)));
                },
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Container(
              height: 140,
              width: 140,
              child: RaisedButton(
                color: Colors.white,
                textColor: primaryColor,
                hoverColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: primaryColor, width: 3),
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Icon(FontAwesomeIcons.wallet,
                          size: 50, color: primaryColor),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Transactions",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     new MaterialPageRoute(
                  //         builder: (context) =>
                  //             RegisterForm(phone, _userType)));
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 140,
              width: 140,
              child: RaisedButton(
                color: Colors.white,
                textColor: primaryColor,
                hoverColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: primaryColor, width: 3),
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Icon(FontAwesomeIcons.phoneAlt,
                          size: 50, color: primaryColor),
                      SizedBox(height: 20),
                      Text(
                        "Place Order",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     new MaterialPageRoute(
                  //         builder: (context) =>
                  //             Requests(phone)));
                },
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Container(
              height: 140,
              width: 140,
              child: RaisedButton(
                color: Colors.white,
                textColor: primaryColor,
                hoverColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: primaryColor, width: 3),
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Icon(FontAwesomeIcons.wallet,
                          size: 50, color: primaryColor),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Emergency", style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     new MaterialPageRoute(
                  //         builder: (context) =>
                  //             RegisterForm(phone, _userType)));
                },
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
