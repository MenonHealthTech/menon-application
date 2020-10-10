import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

import 'package:image_picker/image_picker.dart';
import 'package:menon/constants/app_colors.dart';
import 'package:menon/firestore/db.dart';
import 'package:menon/modals/Doctor.dart';
import 'package:menon/screens/DoctorHome/DoctorHome_mobile.dart';
import 'package:menon/widgets/Loading.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterDoctor extends StatefulWidget {
  final String phone;

  RegisterDoctor(this.phone);

  @override
  _RegisterDoctorState createState() => _RegisterDoctorState(phone);
}

class _RegisterDoctorState extends State<RegisterDoctor> {
  Doctor d = Doctor();
  IconData eye = Icons.visibility_off;
  bool _pass = true;
  String phone;
  String fName, lName, email, degree, fee, pass, cPass, followUpfee, packageFee;
  String upi, account, ifsc, pkg;
  String regNo, address, experience;
  String _upi = "none", _account = "none", _pkg = "none";
  bool checkBoxValuePP = false, checkBoxValueTC = false;
  File _image, _profile;
  var temp;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  final _db = FirebaseFirestore.instance;

  /*Widget _buildImagePicker() {
    return (Center(
      child: _image == null
    ));

  }

  Future getImage()async{
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });

  }*/

  /*Future getImage() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files.length == 1) {
        _image = files[0];
        FileReader reader = FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            temp = reader.result;
          });
        });

        reader.onError.listen((fileEvent) {
          setState(() {
            var st = "Some Error occured while reading the file";
          });
        });

        reader.readAsArrayBuffer(_image);
      }
    });
  }

  Future getProfile() async {
    web.InputElement uploadInput = web.FileUploadInputElement();
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files.length == 1) {
        _profile = files[0];
        web.FileReader reader = web.FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            temp = reader.result;
          });
        });

        reader.onError.listen((fileEvent) {
          setState(() {
            var st = "Some Error occured while reading the file";
          });
        });

        reader.readAsArrayBuffer(_profile);
      }
    });
  }
*/
  _RegisterDoctorState(this.phone);

  Widget _buildFName() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
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
          fName = value;
        },
      ),
    );
  }

  /* Widget _buildImagePicker() {
    return (Center(
      child: new Column(
        children: [
          Text(
            "Upload Degree/Licence Document for Verification",
            style: TextStyle(
              fontSize: 16,
              color: primaryColor,
            ),
          ),
          OutlineButton(
              color: primaryColor,
              onPressed: getImage,
              child: Icon(
                Icons.add_a_photo,
                color: primaryColor,
              )),
        ],
      ),
    ));
  }

  Widget _buildProfilePicture() {
    return (Center(
      child: new Column(
        children: [
          Text(
            "Upload Profile Picture",
            style: TextStyle(
              fontSize: 20,
              color: primaryColor,
            ),
          ),
          OutlineButton(
              color: primaryColor,
              onPressed: getProfile,
              child: Icon(
                Icons.perm_identity_outlined,
                color: primaryColor,
              )),
        ],
      ),
    ));
  }
*/
  Widget _buildLName() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
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
          // if (!re.hasMatch(value)) return "Please Enter Alphabets";

          return null;
        },
        onSaved: (value) {
          lName = value;
        },
      ),
    );
  }

  Widget _buildEmail() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
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
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          // RegExp re = new RegExp(
          //     r'/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/');
          // if (!re.hasMatch(value)) return "Please Enter Valid Email";

          return null;
        },
        onSaved: (value) {
          email = value;
        },
      ),
    );
  }

  Widget _buildDegree() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: "Degree",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.campaign),
          labelText: ("Degree"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }

          return null;
        },
        onSaved: (value) {
          degree = value.toUpperCase();
        },
      ),
    );
  }

  Widget _buildFee() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Per Consultation Fee in Rs",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.monetization_on),
          labelText: ("Per Consultation Fee in Rs"),
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
          fee = value;
        },
      ),
    );
  }

  Widget _buildPackageFee() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Package Fee in Rs for 20 days",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.monetization_on),
          labelText: ("Package fee 20 days"),
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
          packageFee = value;
        },
      ),
    );
  }

  Widget _buildFollowUpFee() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Follow Up fee in Rs",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.monetization_on),
          labelText: ("Follow Up fee in Rs"),
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
          followUpfee = value;
        },
      ),
    );
  }

  Widget _buildPass() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
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
              }),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          if (value.length < 6) {
            return "Password must contain atleast 6 characters";
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
        cursorColor: primaryColor,
        obscureText: true,
        maxLength: 10,
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
            return "Password must contaian atleast 6 chachacters";
          }

          return null;
        },
        onSaved: (value) {
          cPass = value;
        },
      ),
    );
  }

  Widget _buildPackage() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: "Days in package",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.calendar_view_day_sharp),
          labelText: ("Days"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          return null;
        },
        onSaved: (value) {
          upi = value;
        },
      ),
    );
  }

  Widget _buildPkgFees() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: "Fees",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.calendar_view_day_sharp),
          labelText: ("Fees in Rs."),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          return null;
        },
        onSaved: (value) {
          upi = value;
        },
      ),
    );
  }

  Widget _buildUPI() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: "UPI ID",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.credit_card),
          labelText: ("UPI ID"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          return null;
        },
        onSaved: (value) {
          upi = value;
        },
      ),
    );
  }

  Widget _buildAccountNumber() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: "Account Number",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.account_balance),
          labelText: ("A/c Number"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          return null;
        },
        onSaved: (value) {
          account = value;
        },
      ),
    );
  }

  Widget _buildIFSC() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: "IFSC Number",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.account_balance),
          labelText: ("IFSC"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          return null;
        },
        onSaved: (value) {
          ifsc = value;
        },
      ),
    );
  }

  Widget _buildRegNo() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: "Medical Council Registration Number",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.card_membership),
          labelText: ("Medical Council Registration Number"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          return null;
        },
        onSaved: (value) {
          regNo = value;
        },
      ),
    );
  }

  Widget _buildAddress() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: "Address",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.post_add),
          labelText: ("Address"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          return null;
        },
        onSaved: (value) {
          address = value;
        },
      ),
    );
  }

  Widget _buildExperience() {
    return Theme(
      data: ThemeData(primaryColor: primaryColor),
      child: TextFormField(
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: "Experience in years",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          prefixIcon: Icon(Icons.calendar_today),
          labelText: ("Experience"),
        ),
        validator: (String value) {
          // ignore: unrelated_type_equality_checks
          if (value.isEmpty) {
            return 'This is Required';
          }
          return null;
        },
        onSaved: (value) {
          experience = value;
        },
      ),
    );
  }

  final GlobalKey<FormState> _dFormKey = GlobalKey<FormState>();
  var _status = ["Yes", "No"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(24),
        child: Form(
            key: _dFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                //_buildProfilePicture(),
                //_buildImagePicker(),
                SizedBox(height: 10),
                Center(
                  child: _profile == null
                      ? Text('Profile photo not selected',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold))
                      : Text(
                          "Profile Photo Selected",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                ),
                SizedBox(height: 10),
                _buildFName(),
                SizedBox(height: 10),
                _buildLName(),
                SizedBox(height: 10),
                _buildRegNo(),
                SizedBox(
                  height: 10,
                ),
                _buildEmail(),
                SizedBox(height: 10),
                _buildAddress(),
                SizedBox(height: 10),
                _buildExperience(),
                SizedBox(
                  height: 10,
                ),
                _buildFee(),
                SizedBox(height: 10),
                _buildPackageFee(),
                SizedBox(height: 10),
                _buildFollowUpFee(),
                SizedBox(height: 10),
                _buildDegree(),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Do you offer any special packege?",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    RadioGroup<String>.builder(
                      direction: Axis.horizontal,
                      groupValue: _pkg,
                      onChanged: (value) => setState(() {
                        _pkg = value;
                      }),
                      items: _status,
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                    )
                  ],
                ),
                () {
                  if (_pkg == "Yes") {
                    return _buildPackage();
                  } else {
                    return SizedBox();
                  }
                }(),
                SizedBox(
                  height: 10,
                ),
                () {
                  if (_pkg == "Yes") {
                    return _buildPkgFees();
                  } else {
                    return SizedBox();
                  }
                }(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Do you have UPI?",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    RadioGroup<String>.builder(
                      direction: Axis.horizontal,
                      groupValue: _upi,
                      onChanged: (value) => setState(() {
                        _upi = value;
                      }),
                      items: _status,
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                    )
                  ],
                ),
                () {
                  if (_upi == "Yes") {
                    return _buildUPI();
                  } else {
                    return SizedBox();
                  }
                }(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bank Account?",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    RadioGroup<String>.builder(
                      direction: Axis.horizontal,
                      groupValue: _account,
                      onChanged: (value) => setState(() {
                        _account = value;
                      }),
                      items: _status,
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                    )
                  ],
                ),
                () {
                  if (_account == "Yes") {
                    return _buildAccountNumber();
                  } else {
                    return SizedBox();
                  }
                }(),
                SizedBox(
                  height: 10,
                ),
                () {
                  if (_account == "Yes") {
                    return _buildIFSC();
                  } else {
                    return SizedBox();
                  }
                }(),
                SizedBox(height: 10),
                _buildPass(),
                SizedBox(height: 10),
                _buildCPass(),
                SizedBox(height: 10),
                // _buildImagePicker(),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: _image == null
                      ? Text('No Document Selected.',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold))
                      : Text(
                          "Document Selected",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: checkBoxValueTC,
                        onChanged: (bool val) =>
                            setState(() => checkBoxValueTC = val)),
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
                    Checkbox(
                      value: checkBoxValuePP,
                      onChanged: (bool val) =>
                          setState(() => checkBoxValuePP = val),
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
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                    color: primaryColor,
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () async {
                      if (!_dFormKey.currentState.validate() && _image == null)
                        return null;
                      if (!checkBoxValuePP || !checkBoxValueTC) {
                        Widget okButton = FlatButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                        AlertDialog alert = AlertDialog(
                          title: Text("Error"),
                          content:
                              Text("Terms and Condition \n Privacy Policy"),
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
                        return null;
                      }
                      if ((_upi == "none" && _account == "none") ||
                          (_upi == "No" && _account == "No")) {
                        Widget okButton = FlatButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                        AlertDialog alert = AlertDialog(
                          title: Text("Error"),
                          content: Text("Select atleast one payment method"),
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
                        print("Select one payment");
                        return null;
                      }
                      if (pass != cPass) {
                        Widget okButton = FlatButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                        AlertDialog alert = AlertDialog(
                          title: Text("Error"),
                          content: Text("Password Mismatch!"),
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
                        return null;
                      }

                      String fcmToken = await firebaseMessaging.getToken();

                      _dFormKey.currentState.save();
                      d.consultationFee = fee;
                      d.degree = degree;
                      d.document = _image;
                      d.profile = _profile;
                      d.email = email;
                      d.firstName = fName;
                      d.lastName = lName;
                      d.upiid = upi;
                      d.accountNo = account;
                      d.ifsc = ifsc;
                      d.verified = true;
                      d.phone = phone;
                      d.regNo = regNo;
                      d.address = address;
                      d.experience = experience;
                      d.packageFee = packageFee;
                      d.followUpFee = followUpfee;
                      d.fcmToken = fcmToken;

                      var rt = await DB().createDoctor(d, pass);
                      if (rt == null) {
                        return Loading();
                      }
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorHome(phone)));
                    })
              ],
            )),
      ),
    );
  }
}
