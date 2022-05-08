import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moll_app/screen/scan.dart';

import '../component/primaryButton.dart';

class MycompDetails extends StatefulWidget {
  const MycompDetails({
    Key? key,
  }) : super(key: key);
  @override
  _MycompDetailsState createState() => _MycompDetailsState();
}

class _MycompDetailsState extends State<MycompDetails> {
  String msg = "";

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int priceFull = 1;
    String name = "";
    int taxNum = 1;
    int tax = 1;
    String date = "";
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal,
          title: Text('بيانات المسابقة:'),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.analytics_outlined,
                    color: Colors.teal,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "تفاصيل ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text('الحالة :   ',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    '$name',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                children: [
                  Text('عدد النقاط :   ',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    '$taxNum',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                      PrimaryButton(
                    color: Colors.teal,
                    text: "اختر المول",
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QRViewExample(id:1)
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.grey,
              ),

         
        
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
