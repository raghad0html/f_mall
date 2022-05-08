
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'MycompDetails.dart';
import 'connect.dart';

class Mycompetition extends StatefulWidget {
   final int user_id;
   

  const Mycompetition({Key? key, required this.user_id}) : super(key: key);
  @override
  _MycompetitionState createState() => _MycompetitionState();
}

class _MycompetitionState extends State<Mycompetition> {
  
 List<Mycomp> list1 = [];
    List<Mycomp> list2 = [];
 
   
    List<Mycomp> fromDB(String strJson) {
      final data = jsonDecode(strJson);
      return List<Mycomp>.from(data.map((e) => Mycomp.fromMap(e)));
               }
             
               Future<List<Mycomp>> getData() async {
                 List<Mycomp> list=[];
                 final response = await http.post(Uri.http(new connn().getUrl(), "jtto/allshop_prod.php"),
                     body: {"shop_id" :widget.user_id.toString() });
                 if (response.statusCode == 200) {
                   list = fromDB(response.body).cast<Mycomp>();
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
               appBar:AppBar(backgroundColor:Colors.teal,title: Text(""),) ,
               body: GridView.builder(
                 padding: const EdgeInsets.all(25),
                 itemCount: list2.length,
                 itemBuilder: (context, index) {
                   return  Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       InkWell(
                         onTap:(){
                           Navigator.push(context,
                             MaterialPageRoute(builder: (builder) => MycompDetails()));
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
                         child: Text('رقم المسابقة :'+list2[index].name,style: TextStyle(
                           fontSize: 20.0
                         ),),
                       ),Text('اسم المول :'+ list2[index].price,style: TextStyle(
                         fontSize: 20.0
                       ),),Text('المرحلة :'+ list2[index].price,style: TextStyle(
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
       
       class Mycomp {
  @required int prod_id;
  @required String name;
  @required String icon;
  @required String price;

   Mycomp({required this.prod_id,required this.name,required this.price,required this.icon});
         factory Mycomp.fromMap(Map<String,dynamic> e) {
    return Mycomp(prod_id:e["prod_id"].hashCode,name:e["name"],icon:e["icon"],price:e["price"]);
  }
}
