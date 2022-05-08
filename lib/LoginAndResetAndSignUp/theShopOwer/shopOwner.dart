import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:moll_app/LoginAndResetAndSignUp/Login/login.dart';

import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

import '../../screen/connect.dart';
import 'componenet/shoponerForm.dart';



class ShopOwner extends StatefulWidget {
  @override
  _ShopOwnerState createState() => _ShopOwnerState();
}

class _ShopOwnerState extends State<ShopOwner> {

  bool _isloading = false;
  String msg = "";
  String error = "";
  var user_id;

  void _submitAuthForm(String shopname,String email,
      String numberDays,String password,String shopeCenterName, BuildContext ctx) async {

  var response =
        await http.post(Uri.http(new connn().getUrl(),'jtto/shopOwner.php'), body: {
      'email': email,
      'password': password,
      'shopname': shopname,
      'numberDays': numberDays,
      'shopeCenterName':shopeCenterName

    });
    setState(() {
      msg = jsonDecode(response.body);
    });
    switch (msg) {
      case 'INCERTED':
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) =>
          LoginScreen()
        ));
        break;
      case 'EXISTS':
       
        break;
      case 'not exsits':
        error = 'null';
        break;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ShopOwnerform(_submitAuthForm,_isloading),
    );
  }
}
