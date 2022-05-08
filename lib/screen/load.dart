import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:moll_app/screen/billScreen.dart';
import 'package:moll_app/screen/dataFalse.dart';
import 'package:moll_app/screen/datatrue.dart';

class LoadScreen extends StatefulWidget {
  final String code;
  final int user_id;
  const LoadScreen({Key? key, required this.code, required this.user_id})
      : super(key: key);
  @override
  __LoadScreenState createState() => __LoadScreenState();
}

class __LoadScreenState extends State<LoadScreen> {
  Future<void> QRdata() async {
    var result;
    var _nowtime = DateTime.now();
    var e = await http.post(Uri.http('mall-app.com', 'jtto/qr.php'), body: {
      'userid': widget.user_id.toString(),
      'qr': widget.code,
      'qrDate': _nowtime
    });
    setState(() {
      result = jsonDecode(e.body);

      if (result["qrType"] == "sticker") {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>DataTrue(
                    e: result,
                    point: result["points"],
                    totalpoint: result["ballancePonints"])));


      } 
      else if (result["qrType"] == "invoice") {
          Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>DataBill(
                    e: result,)));

      }
       else if (result["qrType"] == "unknown") {
      Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => DataFalse()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    QRdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SafeArea(
            child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(children: [
                  Spacer(flex: 1),
                  Text(
                    "LOADING....",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ]))));
  }
}
