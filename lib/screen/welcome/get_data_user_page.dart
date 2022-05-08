import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moll_app/local_storage/shared_prefernce_services.dart';
import 'package:moll_app/mall_sdk.dart';
import 'package:moll_app/screen/TabBar_Screen.dart';

class GetDataUserPage extends StatefulWidget {
  const GetDataUserPage({Key? key}) : super(key: key);

  @override
  State<GetDataUserPage> createState() => _GetDataUserPageState();
}

class _GetDataUserPageState extends State<GetDataUserPage> {
  bool _error = false;
  var msg;

  @override
  void initState() {
    _submitLogin(LocalStorageService().email!, LocalStorageService().password!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: !_error
            ? SizedBox(
                width: 50, height: 50, child: CircularProgressIndicator(color: Colors.teal,))
            : ElevatedButton(
                onPressed: () {
                  setState(() {
                    _error = true;
                    _submitLogin(LocalStorageService().email!,
                        LocalStorageService().password!);
                  });

                },
                child: Text('اعادة المحاولة')),
      ),
    );
  }

  void _submitLogin(
    String email,
    String password
  ) async {
    var response = await http.post(Uri.https('bareeqe.sa', 'mob_app/login.php'),
        body: {'email': email, 'password': password});
    setState(() {
      msg = jsonDecode(response.body);
    });
    if (msg['login'] != "success") {
      setState(() {
        _error = true;
      });
    } else {
      MallSdk.userId = msg['user_id'];
      MallSdk.token = msg['token'];
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TabBar_Screen(
                user_id: msg['user_id'].hashCode,
                user_data: msg,
              )));
    }
  }
}
