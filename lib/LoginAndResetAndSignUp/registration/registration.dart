
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:moll_app/LoginAndResetAndSignUp/Login/login.dart';
import '../../screen/connect.dart';
import 'component/registrationForm.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {


  String msg = "";
  String error = "";

  void _submitAuthForm(String email, String password, String username,String number,
       BuildContext ctx) async {
            var response =
        await http.post(Uri.http(new connn().getUrl(), 'jtto/sign_up.php'), body: {
      'email': email,
      'password': password,
      'username': username,
      'number': number,
      
    });
    setState(() {
      msg = jsonDecode(response.body);
    });
    switch (msg) {
      case 'INCERTED':
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) =>
            LoginScreen(),
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: RegistrationForm(_submitAuthForm),
      ),
    );
  }
}
