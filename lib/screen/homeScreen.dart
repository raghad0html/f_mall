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
  List<MyMall> mallList = [];

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
      //   "cityId": "1"
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
        mallList = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          automaticallyImplyLeading: true,
          title: Text('المولات'),
          backgroundColor: Colors.teal,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: mallList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => PrimaryScreen(
                              mall_id: mallList[index].mall_id,
                              mall_name: mallList[index].mall_name,
                              icon: mallList[index].icon,
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
                        imageUrl: MallSdk.imageUrl + mallList[index].icon,
                        alignment: Alignment.center,
                        placeholder: (s, e) => Center(
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(color: Colors.teal,),
                          ),
                        ),
                        errorWidget: (e, r, t) => Icon(Icons.error),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      alignment: Alignment.bottomRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mallList[index].mall_name,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            mallList[index].city,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
