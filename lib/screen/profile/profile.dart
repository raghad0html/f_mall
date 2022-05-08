import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../LoginAndResetAndSignUp/registration/component/CameraUserPickImage.dart';
import 'component/build name.dart';

class profile extends StatefulWidget {
  final user_data;

  const profile({Key? key, this.user_data, }) : super(key: key);
  @override
  __profileScreenState createState() => __profileScreenState();
}

class __profileScreenState extends State<profile> {
 /* List<myfile> list1 = [];
  List<myfile> list2 = [];

  var index;

  List<myfile> fromDB(String strJson) {
    final data = jsonDecode(strJson);
    return List<myfile>.from(data.map((e) => myfile.fromMap(e)));
  }

  Future<List<myfile>> getData() async {
    List<myfile> list = [];
    final response = await http.post(
        Uri.http('mall-app.com', "jtto/up_dateprofile.php"),
        body: {"action": "getuser", "user_id": widget.user_id.toString()});
    if (response.statusCode == 200) {
      list = fromDB(response.body).cast<myfile>();
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
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 25),
          CameraUserPickImage(
            imagepickFn: (File pickedImage) => null,
            imagePath: "",
          ),
          const SizedBox(height: 24),
          buildName(widget.user_data['name'], widget.user_data['email'],widget.user_data['number']),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

/*class myfile {
  @required
  int user_id;
  @required
  String name;
  @required
  String email;
  @required
  String pic;
  @required
  String number;
  @required
  String point;

  myfile(
      {required this.user_id,
      required this.name,
      required this.email,
      required this.pic,
      required this.number,
      required this.point});

  factory myfile.fromMap(Map<String, dynamic> e) {
    return myfile(
        user_id: e["user_id"].hashCode,
        name: e["name"],
        email: e["email"],
        pic: e["pic"],
        number: e["number"],
        point: e["point"]);
  }
}*/
