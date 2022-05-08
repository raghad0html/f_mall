import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:moll_app/screen/TabBar_Screen.dart';
import 'package:moll_app/screen/connect.dart';

import 'component/LoginForm.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isloading = true;
  var msg;
  var error;
  void _submitLogi(String email, String password /*, bool islogin,*/,
      BuildContext ctx) async {
    var response = await http.post(Uri.http(new connn().getUrl(), 'jtto/login.php'),
        body: {'email': email, 'password': password});
    setState(() {
      msg = jsonDecode(response.body);
    });
    if (msg == "wrong") {
      setState(() {
        error = 'false';
      });
    } else  {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TabBar_Screen(user_id: msg['user_id'].hashCode,user_data: msg,)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: LoginForm(_submitLogi, _isloading),
      ),
    );
  }
}
