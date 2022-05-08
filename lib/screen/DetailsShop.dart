
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'ApiClass/Myprod.dart';
import 'connect.dart';

class DetailsShop extends StatefulWidget {
   final int shop_id;
   final String shop_name;

  const DetailsShop({Key? key, required this.shop_id, required this.shop_name}) : super(key: key);
  @override
  __DetailsShopState createState() => __DetailsShopState();
}

class __DetailsShopState extends State<DetailsShop> {
  
 List<Myprod> list1 = [];
    List<Myprod> list2 = [];
 
   
    List<Myprod> fromDB(String strJson) {
      final data = jsonDecode(strJson);
      return List<Myprod>.from(data.map((e) => Myprod.fromMap(e)));
               }
             
               Future<List<Myprod>> getData() async {
                 List<Myprod> list=[];
                 final response = await http.post(Uri.http(new connn().getUrl(), "jtto/allshop_prod.php"),
                     body: {"shop_id" :widget.shop_id.toString() });
                 if (response.statusCode == 200) {
                   list = fromDB(response.body).cast<Myprod>();
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
               appBar:AppBar(backgroundColor:Colors.teal,title: Text(widget.shop_name),) ,
               body: GridView.builder(
                 padding: const EdgeInsets.all(25),
                 itemCount: list2.length,
                 itemBuilder: (context, index) {
                   return  Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       InkWell(
                         onTap:(){
                          // Navigator.push(context,
                            // MaterialPageRoute(builder: (builder) => MollScreen()));
                           } ,
                         borderRadius: BorderRadius.circular(15),
                         child: Card(
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(15),
                           ),
                           elevation: 4,
                           margin: EdgeInsets.all(10),
                           child: Column(
                             children:[
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
                                       'https://mall-app.com/img/'+list2[index].icon),
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
                                      list2[index].name,
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
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 10.0,right: 8.0,bottom: 8.0),
                         child: Text('إسم المنتج:'+list2[index].name,style: TextStyle(
                           fontSize: 20.0
                         ),),
                       ),Text('سعر المنتج:'+ list2[index].price,style: TextStyle(
                         fontSize: 20.0
                       ),),
                     ],
                   );
                 },
                 gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                   maxCrossAxisExtent: 400,
                   childAspectRatio: 1,
                   mainAxisSpacing: 20.0,
                 ),
               ),
             ),
           );
         }
       }
       
