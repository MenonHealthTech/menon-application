import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menon/constants/app_colors.dart';
import 'package:menon/firestore/db.dart';
import 'package:menon/widgets/Loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawerHeader extends StatelessWidget {
  final String phone;
  String DocFname, DocLname;

  NavigationDrawerHeader(this.phone);


    var profileImage = new Image(
      image: new AssetImage('Images/profile picture.jpg'),
      height: 300,
      width: 200);

  @override
  Widget build(BuildContext context) {
    var pd;

    return Container(
      height: 200,
      color: primaryColor,
      alignment: Alignment.center,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20),
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: new AssetImage('Images/profile picture.jpg'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 20),
            child: GestureDetector(
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FutureBuilder(
                          future: DB().getUser(phone),
                          builder: (BuildContext context,
                              AsyncSnapshot asyncSnapshot) {
                            if (asyncSnapshot.data == null) {
                              return Loading();
                            } else {
                              pd = asyncSnapshot.data;
                              DocFname = asyncSnapshot.data.firstName;
                              DocLname = asyncSnapshot.data.lastName;
                              print("in reading book pos");
                              print(DocFname);
                              MyFun();
                              return Text(
                                asyncSnapshot.data.firstName +
                                    " " +
                                    asyncSnapshot.data.lastName,
                                style: TextStyle(color: Colors.white),
                              );
                            }
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'User Profile',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Navigator.of(context).push(new MaterialPageRoute(
                      //     builder: (context) => ProfileUser(pd)));
                    },
                  )
                ],
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  void MyFun() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("DocFname", DocFname);
    preferences.setString("DocLname", DocLname);
  }
}