import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moll_app/screen/connect.dart';
import 'package:moll_app/screen/primary.dart';

import 'ApiClass/MyMall.dart';
import 'MallScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  __HomeScreenState createState() => __HomeScreenState();
}

class __HomeScreenState extends State<HomeScreen> {


  List<MyMall> list1 = [];
  List<MyMall> list2 = [];
  List<MyMall> fromDB(String strJson) {
    final data = jsonDecode(strJson);
    return List<MyMall>.from(data.map((e) => MyMall.fromMap(e)));
  }

  Future<List<MyMall>> getData() async {
    List<MyMall> list = [];
    final response = await http.post(
        Uri.http(new connn().getUrl(), new connn().getMall()),
        body: {"action": "getAll"});
    if (response.statusCode == 200) {
      list = fromDB(response.body).cast<MyMall>();
    }
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    getData().then((value) {
      setState(() {
        list1 = value;
        list2 = list1;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(25),
        itemCount: list2.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => PrimaryScreen(
                            mall_id: list2[index].mall_id,
                            mall_name: list2[index].mall_name,
                            icon: list2[index].icon,
                          )));
            },
            borderRadius: BorderRadius.circular(15),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image(
                          height: 80,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'https://mall-app.com/jtto/img/' +
                                list2[index].icon,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 10,
                        child: Container(
                          width: 300,
                          color: Colors.black54,
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 20,
                          ),
                          child: Text(
                            list2[index].mall_name,
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.7,
          crossAxisSpacing: 35,
          mainAxisSpacing: 35,
        ),
      ),
    );
  }
}


