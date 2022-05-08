import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:moll_app/mall_sdk.dart';
import 'package:moll_app/screen/connect.dart';
import 'package:moll_app/screen/primary.dart';

import 'ApiClass/MyMall.dart';

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
    final response = await http
        .post(Uri.https(new connn().getUrl(), new connn().getMall()), body: {
      "action": "getMalls",
      "token": MallSdk.token,
      "userid": MallSdk.userId,
      "cityId": "1"
    });
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
        padding: const EdgeInsets.all(10),
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
              elevation: 2,
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: MallSdk.imageUrl + list2[index].icon,
                      alignment: Alignment.center,
                      placeholder: (s, e) => Center(
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (e, r, t) => Icon(Icons.error),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 143,
                    ),
                  ),
                  Text(
                    list2[index].mall_name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.0,
          crossAxisSpacing: 15,
          mainAxisSpacing: 1,
        ),
      ),
    );
  }
}
