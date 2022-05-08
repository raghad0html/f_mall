import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:moll_app/local_storage/shared_prefernce_services.dart';
import 'package:moll_app/mall_sdk.dart';
import 'package:moll_app/screen/TabBar_Screen.dart';

import 'component/LoginForm.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var msg;
  var error;

  void _submitLogi(String email, String password /*, bool islogin,*/,
      BuildContext ctx) async {
    var response = await http.post(Uri.https('bareeqe.sa', 'mob_app/login.php'),
        body: {'email': email, 'password': password});
    setState(() {
      msg = jsonDecode(response.body);
    });
    if (msg['login'] != "success") {
      //todo add snackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('الايميل او كلمة السر غير صحيحين'),
      ));
    } else {
      MallSdk.userId = msg['user_id'];
      MallSdk.token = msg['token'];
      LocalStorageService().login = true;
      LocalStorageService().email = email;
      LocalStorageService().password = password;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TabBar_Screen(
                user_id: msg['user_id'].hashCode,
                user_data: msg,
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: LoginForm(_submitLogi),
      ),
    );
  }
}
