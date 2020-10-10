
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menon/constants/app_colors.dart';
import 'package:menon/firestore/db.dart';
import 'package:menon/modals/Doctor.dart';
import 'package:menon/widgets/Loading.dart';


import 'DoctorProfile.dart';

class DoctordList extends StatefulWidget {
  final String phone;
  DoctordList(this.phone);
  @override
  _DoctordListState createState() => _DoctordListState();
}

class _DoctordListState extends State<DoctordList> {
  Color c;
  List<Doctor> doctors;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
        color: Colors.white,
        child: FutureBuilder(
            future: DB().getDoctors(widget.phone),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Loading();
              } else if (snapshot.data.length == 0) {
                return Container(
                  child: Center(
                    child: Text("No doctors are using this Software"),
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
                        onTap: () {
                          Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => DoctorProfile(
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
