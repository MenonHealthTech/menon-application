import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menon/constants/app_colors.dart';
import 'package:menon/firestore/db.dart';
import 'package:menon/modals/Patient.dart';
import 'package:menon/screens/PatientHome/PatientHome_Mobile.dart';

import 'package:url_launcher/url_launcher.dart';

class RegisterPatient extends StatefulWidget {
  final String phone;

  RegisterPatient(this.phone);
  @override
  _RegisterPatientState createState() => _RegisterPatientState(phone);
}

class _RegisterPatientState extends State<RegisterPatient> {

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  final _db = FirebaseFirestore.instance;


  String phone, gender, covid, pass, cPass;
  IconData eye = Icons.visibility_off;
  bool _pass = true;
  int age;
  bool checkBoxValuePP = false, checkBoxValueTC = false,checkBOD = true;
  DateTime selectedDate;
  _RegisterPatientState(this.phone);
  Patient p;

  Future pickDate() async {
    print("Pick Date");
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2020),
        firstDate: DateTime(1900),
        lastDate: DateTime(2200));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        age = DateTime.now().year - selectedDate.year;
        print(selectedDate.year);
        print(age);
      });
  }

  Widget _buildGender() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            hintText: "Gender",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            prefixIcon: Icon(Icons.people),
            labelText: ("Gender"),
          ),
          items: ["Male", "Female", "Other"]
              .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ))
              .toList(),
          onChanged: (String selected) {
            setState(() {
              gender = selected;
              print(gender);
            });
          }),
    );
  }


  Widget _buildCovid2(){
    return Theme(
      data:ThemeData(primaryColor: primaryColor),
      child: SingleChildScrollView(
        child: DropdownButtonFormField(
            decoration: InputDecoration(
              hintText: "Category",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              prefixIcon: Icon(Icons.coronavirus),
              labelText: ("Covid Status"),
            ),
            items: [
              "I have not tested positive but have Symptoms",
              " I have tested COVID-19 Positive",
              "I am purchasing this kit for Precautionary"
            ]
                .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ))
                .toList(),
            onChanged: (String selected) {
              setState(() {
                covid = selected;
                print(gender);
              });
            }),
      ),
    );
  }



  Widget _buildCovid() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            hintText: "Category",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            prefixIcon: Icon(Icons.coronavirus),
            labelText: ("Covid Status"),
          ),

          items: [
            "I have not tested positive but have Symptoms",
            " I have tested COVID-19 Positive",
            "I am purchasing this kit for Precautionary"
          ]
              .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ))
              .toList(),
          onChanged: (String selected) {
            setState(() {
              covid = selected;
              print(gender);
            });
          }),
    );
  }

  Widget _buildFName() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "First Name",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.perm_identity),
          labelText: ("First Name"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'First Name is Required';
          }
          // RegExp re = new RegExp(r'/^[A-Za-z]+$/');
          // if (!re.hasMatch(value)) return "Please Enter Alphabets";

          return null;
        },
        onSaved: (value) {
          p.firstName = value;
        },
      ),
    );
  }

  Widget _buildDOB() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Date of Birth",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: pickDate,
          color: primaryColor,
          iconSize: 25,
        ),
            () {
          if (selectedDate == null) {
            checkBOD = false;
            return Text(
              "Click on Icon",
              style: TextStyle(fontSize: 18, color: primaryColor),
            );
          }else if(DateTime.now().year <=  selectedDate.year){
            checkBOD = false;
            return Text("Please enter valide year",style: TextStyle(color: Colors.red));
          }
          else if(16 >  (DateTime.now().year - selectedDate.year)){
            checkBOD = false;
            return Text("User age must be above 16",style: TextStyle(color: Colors.red));
          }
          else {
            checkBOD = true;
            return Text(
                selectedDate.day.toString() +
                    "-" +
                    selectedDate.month.toString() +
                    "-" +
                    selectedDate.year.toString(),
                style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.bold));
          }
        }()
      ],
    );
  }

  Widget _buildLName() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Last Name",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.perm_identity),
          labelText: ("Last Name"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          // RegExp re = new RegExp(r'/^[A-Za-z]+$/');
          // if (re.hasMatch(value)) return "Please Enter Alphabets";

          return null;
        },
        onSaved: (value) {
          p.lastName = value;
        },
      ),
    );
  }

  Widget _buildEmail() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Email",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.mail),
          labelText: ("Email"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_check
          // if (value != "" || value != null) {
          //   RegExp re = new RegExp(
          //       r'/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/');
          //   if (!re.hasMatch(value)) return "Please Enter Valid Email";
          // }
          return null;
        },
        onSaved: (value) {
          p.email = value;
        },
      ),
    );
  }

  Widget _buildHeight() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Height (CM)",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.arrow_circle_up),
          labelText: ("Height"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          RegExp re = new RegExp(r'^\d*\.?\d*$');
          if (!re.hasMatch(value)) return "Please Enter Numerics";

          return null;
        },
        onSaved: (value) {
          p.height = value;
        },
      ),
    );
  }

  Widget _buildWeight() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Weight (KG)",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.linear_scale),
          labelText: ("Weight"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          RegExp re = new RegExp(r'^\d*\.?\d*$');
          if (!re.hasMatch(value)) return "Please Enter Numerics";

          return null;
        },
        onSaved: (value) {
          p.weight = value;
        },
      ),
    );
  }

  Widget _buildPass() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        maxLength: 10,
        obscureText: _pass,
        decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            prefixIcon: Icon(Icons.linear_scale),
            labelText: ("Password"),
            suffixIcon: IconButton(
                icon: Icon(eye),
                onPressed: () {
                  setState(() {
                    _pass = !_pass;
                    if (_pass) {
                      eye = Icons.visibility_off;
                    } else {
                      eye = Icons.visibility;
                    }
                  });
                })),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          if (value.length < 6) {
            return "Too Short";
          }

          return null;
        },
        onSaved: (value) {
          pass = value;
        },
      ),
    );
  }

  Widget _buildCPass() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        maxLength: 10,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Confirm Password",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.linear_scale),
          labelText: ("Confirm Password"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          if (value.length < 6) {
            return "Too Short";
          }

          return null;
        },
        onSaved: (value) {
          cPass = value;
        },
      ),
    );
  }

  final GlobalKey<FormState> _pFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24),
      child: Form(
          key: _pFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildFName(),
                SizedBox(height: 10),
                _buildLName(),
                SizedBox(height: 10),
                _buildEmail(),
                SizedBox(height: 10),
                _buildHeight(),
                SizedBox(height: 10),
                _buildWeight(),
                SizedBox(height: 10),
                _buildGender(),
                SizedBox(height: 10),
                _buildCovid(),
                SizedBox(height: 10),
                _buildPass(),
                SizedBox(height: 10),
                _buildCPass(),
                SizedBox(height: 10),
                _buildDOB(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Checkbox(
                          activeColor: primaryColor,
                          value: checkBoxValueTC,
                          onChanged: (bool val) =>
                              setState(() => checkBoxValueTC = val)),
                    ),
                    InkWell(
                      child: Text("Terms and Condition",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue)),
                      onTap: () async {
                        if (await canLaunch(
                            "https://drive.google.com/file/d/1Irj71YFKbfw3G078tCQKfVIIzrczI7m_/view?usp=sharing")) {
                          await launch(
                              "https://drive.google.com/file/d/1Irj71YFKbfw3G078tCQKfVIIzrczI7m_/view?usp=sharing");
                        }
                      },
                    ),
                    Center(
                      child: Checkbox(
                        activeColor: primaryColor,
                        value: checkBoxValuePP,
                        onChanged: (bool val) =>
                            setState(() => checkBoxValuePP = val),
                      ),
                    ),
                    InkWell(
                      child: Text("Privacy Policy",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue)),
                      onTap: () async {
                        if (await canLaunch(
                            "https://drive.google.com/file/d/1wtdgiOLp44iJkXsbdodO1PDiUujf9-y_/view?usp=sharing")) {
                          await launch(
                              "https://drive.google.com/file/d/1wtdgiOLp44iJkXsbdodO1PDiUujf9-y_/view?usp=sharing");
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                RaisedButton(
                    color: primaryColor,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () async {
                      if (!_pFormKey.currentState.validate()) return;
                      if (pass != cPass) {
                        Widget okButton = FlatButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                        AlertDialog alert = AlertDialog(
                          title: Text("Error"),
                          content: Text("Password mismatched"),
                          actions: [
                            okButton,
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                        return;
                      }
                      if (!checkBOD) {
                        Widget okButton = FlatButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                        AlertDialog alert = AlertDialog(
                          title: Text("Error"),
                          content: Text("Please enter valid Date Of Birth"),
                          actions: [
                            okButton,
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                        return;
                      }
                      if (!checkBoxValuePP || !checkBoxValueTC) {
                        Widget okButton = FlatButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                        AlertDialog alert = AlertDialog(
                          title: Text("Error"),
                          content: Text(
                              "Please Accept \n1. Terms and Condition.\n2. Privacy Policy."),
                          actions: [
                            okButton,
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                        return;
                      }

                      showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      //var stat = await DB().notification(phone);
                      String fcmToken = await firebaseMessaging.getToken();
                      p = Patient();
                      _pFormKey.currentState.save();
                      p.dob = selectedDate;
                      p.phone = phone;
                      p.age = age.toString();
                      p.gender = gender;
                      p.covidStatus = covid;
                      p.fcmToken = fcmToken;
                      bool stat = true;
                      var rt = await DB().createPatient(p, pass);
                      if (rt != null) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => PatientHome(phone)));
                      }
                    }),
              ],
            ),
          )),
    );
  }
}
