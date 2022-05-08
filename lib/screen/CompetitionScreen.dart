
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'ApiClass/como.dart';
import 'connect.dart';

class CompetitionScreen extends StatefulWidget {
   final int mall_id;
   final String mall_name;
  const CompetitionScreen({Key? key, required this.mall_id, required this.mall_name}) : super(key: key);
  @override
  _CompetitionScreenState createState() => _CompetitionScreenState();
}

class _CompetitionScreenState extends State<CompetitionScreen> {
  
 List<comp> list1 = [];
    List<comp> list2 = [];
 
   
    List<comp> fromDB(String strJson) {
      final data = jsonDecode(strJson);
      return List<comp>.from(data.map((e) => comp.fromMap(e)));
               }
             
               Future<List<comp>> getData() async {
                 List<comp> list=[];
                 final response = await http.post(Uri.http(new connn().getUrl(), "jtto/allprize.php"),
                     body: {"mall_id" :widget.mall_id.toString() });
                 if (response.statusCode == 200) {
                   list = fromDB(response.body).cast<comp>();
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
               appBar:AppBar(backgroundColor:Colors.teal,title: Text(widget.mall_name),) ,
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
                         child: Text(list2[index].name,style: TextStyle(//اسم المسابقة
                           fontSize: 20.0
                         ),),
                       ),
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
       
  
