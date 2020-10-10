import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:menon/constants/app_colors.dart';
import 'package:menon/firestore/db.dart';
import 'package:menon/modals/ListItem.dart';

class addOtherReports extends StatefulWidget {
  final String phone;

  addOtherReports(this.phone);

  @override
  _addOtherReportsState createState() => _addOtherReportsState(phone);
}

class _addOtherReportsState extends State<addOtherReports> {
  File _image;
  String imageLink;
  final String phone;
  _addOtherReportsState(this.phone);

  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  List<ListItem> _dropdownItems = [
    ListItem(1, "Sugar"),
    ListItem(2, "Blood Pressure"),
    ListItem(3, "Asthma"),
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  _buildOther(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: primaryColor,
          border: Border.all()),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: _selectedItem,
          items: _dropdownMenuItems,
          onChanged: (value) {
            setState(() {
              _selectedItem = value;
              print("You selects items");
              print(_selectedItem.name);
            });
          },
        ),
      ),
    );
  }

  _buildImagePicker() {
    return (Center(
      child: new Column(
        children: [
          _image == null
              ? Text("Upload Report Image",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ))
              : Image.file(_image, height: 350.0, width: 500.0),
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

  //child: _image == null ? Text("Report Image"): Image.file(_image),

  _buildButton() {
    return Container(
      margin: EdgeInsets.only(top: 1.0),
      width: 250.0,
      height: 50.0,
      child: RaisedButton(
          color: primaryColor,
          child: Text(
            "Send",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 25.0),
          ),
          elevation: 6.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
          onPressed: () async {
            FirebaseStorage fs = FirebaseStorage.instance;
            StorageReference rootRef = fs.ref();
            StorageReference pictureFolderRef =
                rootRef.child("Pictures").child("image");
            pictureFolderRef
                .putFile(_image)
                .onComplete
                .then((storageTask) async {
              String Link = await storageTask.ref.getDownloadURL();

              setState(() {
                  imageLink = Link;
                  var val =  DB().storeLink(phone,imageLink,_selectedItem);

              });
            });
          }),
    );
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
            SizedBox(
              height: 10,
            ),
            Text(
              "Select Report Type",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            _buildOther(context),
            SizedBox(
              height: 30,
            ),
            _buildImagePicker(),
            SizedBox(
              height: 30,
            ),
            _buildButton(),
          ],
        ),
      )),
    );
  }
}

// Scaffold(
// appBar: AppBar(
// title: Text("Other Reports"),
// ),
// body: Container(
// padding: EdgeInsets.all(20.0),
// child: DropdownButton(
// value: _value,
// items: [
// DropdownMenuItem(
// child: Text("Blood Pressure(BP)"),
// value: 1,
// ),
// DropdownMenuItem(
// child: Text("Asthma"),
// value: 2,
// ),
// DropdownMenuItem(
// child: Text("Sugar"),
// value: 3
// ),
// DropdownMenuItem(
// child: Text("Overweight and Obesity"),
// value: 4
// )
// ],
// onChanged: (value) {
// setState(() {
// _value = value;
// });
// }),
// ));
