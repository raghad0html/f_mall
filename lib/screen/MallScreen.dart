import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'ApiClass/Myshop.dart';
import 'DetailsShop.dart';
import 'connect.dart';


class MollScreen extends StatefulWidget {
  final int mall_id;
  final String mall_name;
   final String icon;
  const MollScreen({Key? key, required this.mall_id, required this.mall_name, required this.icon}) : super(key: key);
  @override
  __MollScreenState createState() => __MollScreenState();
}

class __MollScreenState extends State<MollScreen> {

 List<Myshop> lists= [];
   List<Myshop> lists2 = [];

  
   List<Myshop> fromDB(String strJson) {
     final data = jsonDecode(strJson);
     return List<Myshop>.from(data.map((e) => Myshop.fromMap(e)));
        }
      

       Future<List<Myshop>> getData() async {
         List<Myshop> list=[];
         
         final response = await http.post(Uri.http(new connn().getUrl(), "jtto/allshop.php"),
             body: {"mall_id" :widget.mall_id.toString()});
         if (response.statusCode == 200) {
           list = fromDB(response.body).cast<Myshop>();
         }
         return list;
       }
      
        @override
        void initState() {
          // TODO: implement initState
          getData().then((value) {
            setState(() {
              lists = value;
              lists2 = lists;
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
                backgroundColor: Colors.teal,
                title: Text(widget.mall_name),
              ),
              body: Column(
                children: [
                  Text(widget.icon),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(25),
                      itemCount: lists2.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (builder) => DetailsShop(shop_id: lists2[index].shop_id,shop_name: lists2[index].name,)));
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
                               children:[
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
                                         'https://mall-app.com/jtto/img/'+lists2[index].icon),
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
                                      lists2[index].name,
                                       style: TextStyle(
                                         fontSize: 26,
                                         color: Colors.white,
                                       ),
                                       softWrap: true,
                                       overflow: TextOverflow.fade,
                                     ),
                                   ),
                                 )
                             ],),
                           ], ),
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }
      
  