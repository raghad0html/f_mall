import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moll_app/local_storage/shared_prefernce_services.dart';
import 'package:moll_app/screen/welcome/signuporsignin.dart';
import '../notification.dart';

import '../profile/profile.dart';
import 'points.dart';
import 'whowe are.dart';

class MainDrawer extends StatefulWidget {
  final user_data;

  const MainDrawer({
    Key? key,
    this.user_data,
  }) : super(key: key);

  @override
  __MainDrawerScreenState createState() => __MainDrawerScreenState();
}

class __MainDrawerScreenState extends State<MainDrawer> {
  String? pointnumber = "0";

  Widget buildListTile(String title, IconData icon, VoidCallback tapHandler ,{Color color = Colors.teal}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(
        leading: Icon(
          icon,
          size: 20,
          color: color,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: tapHandler,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.teal,
              width: double.infinity,
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.centerLeft,
              // color: Theme.of(context).accentColor,
              child: UserAccountsDrawerHeader(
                accountName: Text(
                  widget.user_data['name'],
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  widget.user_data['email'],
                  style: TextStyle(color: Colors.white),
                ),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.teal,
                      size: 35,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildListTile('النقاط', Icons.control_point, () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) =>
                      Points(user_id: widget.user_data['user_id'].hashCode)));
            }),
            buildListTile('الإعلانات', Icons.post_add, () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => notifiction(
                        user_id: widget.user_data['user_id'].hashCode,
                      )));
            }),
            buildListTile("من نحن", Icons.group, () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => WhoWeAre()));
            }),
            buildListTile("تسجيل الخروج", Icons.logout_rounded, () {
              LocalStorageService().LogOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => SigninOrSignupScreen()),
                  ModalRoute.withName('/') // Replace this with your root screen's route name (usually '/')
              );

            } ,color: Colors.red),
          ],
        ),
      ),
    );
  }
}
