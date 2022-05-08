import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'ApiClass/notific.dart';
import 'connect.dart';

class notifiction extends StatefulWidget {
  final int user_id;
    const notifiction({Key? key, required this.user_id}) : super(key: key);

  @override
  _notifictionState createState() => _notifictionState();
}

class _notifictionState extends State<notifiction> {
     List<notific> list1 = [];

    List<notific> list2 = [];

    List<notific> fromDB(String strJson) {
      final data = jsonDecode(strJson);
      return List<notific>.from(data.map((e) => notific.fromMap(e)));
               }

               Future<List<notific>> getData() async {
                 List<notific> list=[];
                 final response = await http.post(Uri.http(new connn().getUrl(), "jtto/allnotification.php"),
                     body: {"action": "getAllnoti",
                     "user_id" :widget.user_id.toString() });
                 if (response.statusCode == 200) {
                   list = fromDB(response.body).cast<notific>();
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: ListView.separated(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://mall-app.com/img/'+list2[index].icon!,
                      ),
                      radius: 30.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(list2[index].mall_name!),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(list2[index].text!),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
            );
          },
          itemCount: list2.length,
        ),
      ),
    );
  }
}
   
