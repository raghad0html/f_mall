import 'package:flutter/material.dart';

class DataTrue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.check_circle,
              size: 50,
              color: Colors.green,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Image(
            image: AssetImage('assets/icons/win.gif'),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text('you win 20 points go to next moll'),
        ],
      ),
    );
  }
}
