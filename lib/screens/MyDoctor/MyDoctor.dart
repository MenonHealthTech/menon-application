import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menon/constants/app_colors.dart';
import 'package:menon/firestore/db.dart';
import 'package:menon/widgets/Loading.dart';

import 'package:url_launcher/url_launcher.dart';
import 'DoctorProfile.dart';

class MyDoctor extends StatefulWidget {
  final String phone;

  MyDoctor(this.phone);

  @override
  _MyDoctorState createState() => _MyDoctorState();
}

class _MyDoctorState extends State<MyDoctor> {
  Color c;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
        color: Colors.white,
        child: FutureBuilder(
            future: DB().getMyDoctor(widget.phone),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Loading();
              } else if (snapshot.data.length == 0) {
                return Container(
                  child: Center(
                    child: Text("You have not added any Doctor Yet."),
                  ),
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
                        leading: CircleAvatar(
                            backgroundImage: AssetImage("Images/doctor.png")),
                        title: Text(
                          snapshot.data[index].firstName +
                              " " +
                              snapshot.data[index].lastName,
                          style: TextStyle(fontSize: 20, color: Colors.white),
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
                        onTap: () {
                          Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => MyDoctorProfile(
                                          widget.phone, snapshot.data[index])))
                              .then((value) {
                            setState(() {});
                          });
                        },
                      );
                    });
              }
            }),
      ),
    );
  }
}
