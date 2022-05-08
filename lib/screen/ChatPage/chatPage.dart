import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../connect.dart';
import 'component/ChatModel.dart';
import 'component/customCard.dart';

class chatPage extends StatefulWidget {
   final int user_id;

  const chatPage({Key? key, required this.user_id}) : super(key: key);
  @override
  _chatPageState createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
 /* List<chatModel> chats = [
    chatModel(
      mall_id: 1,
      name: "صحارى مول",
      icon: "person.svg",
      isGroup: false,
      time: "4:00",
      currentMessage: "hi",
      status: "",
    ),
  ];
*/





  List<chatModel> chats1 = [];
  List<chatModel> chats = [];
  List<chatModel> fromDB(String strJson) {
    final data = jsonDecode(strJson);
    return List<chatModel>.from(data.map((e) => chatModel.fromMap(e)));

  }

  Future<List<chatModel>> getData() async {
    List<chatModel> list=[];
    final response = await http.post(Uri.http(new connn().getUrl(),"jtto/chat.php"),
        body: {"action": "getAll"});
    if (response.statusCode == 200) {
      list = fromDB(response.body).cast<chatModel>();
    }
    return list;
  }

  @override
  void initState() {
    // TODO: implement initState
    getData().then((value) {
      setState(() {
        chats1 = value;
        chats = chats1;
      });
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) => customCard(
            chatmodel: chats[index],user_id:widget.user_id
          ),
        ),
      ),
    );
  }
}
