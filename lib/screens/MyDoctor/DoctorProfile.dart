
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menon/constants/app_colors.dart';
import 'package:menon/modals/Doctor.dart';


class MyDoctorProfile extends StatelessWidget {
  @required
  final Doctor d;
  final String phone;
  MyDoctorProfile(this.phone, this.d);
  @override
  Widget build(BuildContext context) {
    Color c;
    String t;
    print(d.consultationFee);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Theme(
          data: ThemeData(iconTheme: IconThemeData(color: Colors.black)),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
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
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Card(
          elevation: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("Images/doctor.png"),
              ),
              Divider(),
              SizedBox(
                height: 40,
              ),
              Text("Name",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, color: primaryColor)),
              Text(
                "Dr." + d.firstName + " " + d.lastName,
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  d.degree,
                  style: TextStyle(color: Colors.blue, fontSize: 25),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text("Consultation Fee",
                  style: TextStyle(color: primaryColor, fontSize: 25)),
              Text(
                "Rs." + d.consultationFee,
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
              ),
              FlatButton(
                  onPressed: () {
                    //DB().deleteDoctor(phone, d.phone);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Message"),
                            content: Text("Doctor Removed"),
                            actions: [
                              FlatButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                },
                              )
                            ],
                          );
                        });
                  },
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  child: Text("Remove Doctor",
                      style: TextStyle(fontSize: 30, color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }
}
