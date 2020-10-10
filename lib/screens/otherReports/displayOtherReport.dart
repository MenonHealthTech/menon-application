import 'package:flutter/cupertino.dart';

import 'dart:io';

import 'package:menon/constants/app_colors.dart';

class displayOther extends StatefulWidget {
  final String phone;
  displayOther(this.phone);

  @override
  _displayOtherState createState() => _displayOtherState(phone);
}

class _displayOtherState extends State<displayOther> {
  final String phone;
  String imgLink;

  _displayOtherState(this.phone);

  @override
  void initState() {
    // TODO: implement initState
//    imgLink = DB().getLink(phone) as String;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text(
                "Your Report",
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              imgLink != null ? Image.network(imgLink):Text("Imgae not selected"),
            ],
          ),
        ),
      ),
    );
  }
}
