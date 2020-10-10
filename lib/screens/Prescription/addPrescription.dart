//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:healthmenon/constants/app_colors.dart';
//
// class PrescriptionData extends StatefulWidget {
//   @override
//   _PrescriptionDataState createState() => _PrescriptionDataState();
// }
//
// class _PrescriptionDataState extends State<PrescriptionData> {
//
//
//   Widget _buildFName() {
//     return Theme(
//       data: ThemeData(primaryColor: primaryColor),
//       child: TextFormField(
//         cursorColor: primaryColor,
//         decoration: InputDecoration(
//           hintText: "Give notes",
//           hintStyle: TextStyle(
//             color: Colors.grey,
//             fontSize: 12.0,
//             height: 8.0,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(40.0),
//           ),
//           prefixIcon: Icon(Icons.perm_identity),
//           labelText: ("Prescription / Notes For Patient"),
//         ),
//         onSaved: (String value) {
//           notes = value;
//         },
//         validator: (String value) {
//           return value.contains('@') ? 'Do not use the @ char.' : null;
//         },
//       ),
//     );
//   }
//
//   Widget _buildNotes(){
//     return Theme(
//       data: ThemeData(primaryColor: primaryColor),
//       child: TextFormField(
//         cursorColor: primaryColor,
//         decoration: InputDecoration(
//           hintText: "Give notes for self",
//           hintStyle: TextStyle(
//             color: Colors.grey,
//             fontSize: 12.0,
//             height: 8.0,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(40.0),
//           ),
//           prefixIcon: Icon(Icons.perm_identity),
//           labelText: ("Self Notes"),
//         ),
//         onSaved: (String value) {
//           notes2 = value;
//         },
//         validator: (String value) {
//           return value.contains('@') ? 'Do not use the @ char.' : null;
//         },
//       ),
//     );
//   }
//
//
//
//
//   final GlobalKey<FormState> _dFormKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//             margin: EdgeInsets.all(24),
//             child: Form(
//               key: _dFormKey,
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     //_buildDateTime(),
//                     SizedBox(height: 30),
//                     RaisedButton(
//                       color: primaryColor,
//                       padding: EdgeInsets.all(15),
//                       child: Text("Give Prescriptions", style: TextStyle(fontSize: 23, color: Colors.white)),
//                       onPressed: (){},
//                     ),
//                     //_buildImagePicker(),
//                     SizedBox(height: 10,),
//                     Center(
//                       child: _image == null
//                           ? Text('No Document Selected.',
//                           style: TextStyle(color: Colors.red))
//                           : Text(
//                         "Document Selected",
//                         style: TextStyle(color: Colors.green),
//                       ),
//                     ),
//                     SizedBox(height: 10,),
//                     _buildFName(),
//                     SizedBox(height: 30),
//                     _buildNotes(),
//                     SizedBox(height: 30),
//                     RaisedButton(
//                       color: primaryColor,
//                       padding: EdgeInsets.all(15),
//                       child: Text("Send", style: TextStyle(fontSize: 20, color: Colors.white)),
//                       onPressed: () async {
//                         if (_dFormKey.currentState.validate()) {
//                           _dFormKey.currentState.save();
//                         }
//                         if (_image == null) {
//                           Widget okButton = FlatButton(
//                             child: Text("OK"),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                           );
//                           AlertDialog alert = AlertDialog(
//                             title: Text("Error"),
//                             content: Text("Please Select Prescription Receipt"),
//                             actions: [
//                               okButton,
//                             ],
//                           );
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return alert;
//                             },
//                           );
//                         } else {
//
//                           SharedPreferences preferences =
//                           await SharedPreferences.getInstance();
//                           var pho = preferences.getString("phone");
//                           String fname = preferences.getString("DocFname");
//                           String lname = preferences.getString("DocLname");
//                           String name = fname + " " + lname;
//                           String doctName = fname+"_"+lname;
//                           Patient p = Patient();
//                           p.phone = pho;
//                           print("Notes Here");
//                           print(notes);
//                           p.Notes = notes;
//                           p.Doctor = name;
//                           print(notes);
//                           var rt  = await DB().storePrescriptionImage(doctName,_image,pho,p);
//                           //var rt = await DB().createPrescription(p);
//                           if (rt) {
//                             var alert = AlertDialog(
//                               title: Text("Alert"),
//                               content: Text("Data send successfully"),
//                             );
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return alert;
//                               },
//                             );
//                           } else {
//                             var alert = AlertDialog(
//                               title: Text("Alert"),
//                               content: Text("Error:Data not send"),
//                             );
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return alert;
//                               },
//                             );
//                           }
//                         }
//
//                         // showDialog(
//                         //     context: context,
//                         //     builder: (context) {
//                         //       return Center(
//                         //         child: CircularProgressIndicator(),
//                         //       );
//                         //     });
//                         //String ph = getMyFun() as String;
//                       },
//                     )
//                   ]),
//             )));
//   }
// }
