import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../connect.dart';


class Points extends StatefulWidget {
  final int user_id;
  const Points({Key? key, required this.user_id, }) : super(key: key);
  @override
  __PointsState createState() => __PointsState();
}

class __PointsState extends State<Points> {

 List<Mypoint> lists= [];
   List<Mypoint> lists2 = [];

  
   List<Mypoint> fromDB(String strJson) {
     final data = jsonDecode(strJson);
     return List<Mypoint>.from(data.map((e) => Mypoint.fromMap(e)));
        }
      

       Future<List<Mypoint>> getData() async {
         List<Mypoint> list=[];
         final response = await http.post(Uri.http(new connn().getUrl(), "jtto/data.php"),
             body: {"action":"getUserBlancePoint",
               "user_id" :widget.user_id.toString()});
         if (response.statusCode == 200) {
           list = fromDB(response.body).cast<Mypoint>();
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
                title: Text("نقاطي"),
              ),
              body: Column(
                children: [
                  Text(""),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(25),
                      itemCount: lists2.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
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
                                  child:Text(
                                      lists2[index].name,
                                       style: TextStyle(
                                         fontSize: 26,
                                         color: Colors.white,
                                       ),
                                       softWrap: true,
                                       overflow: TextOverflow.fade,
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
                                      lists2[index].point,
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
      
      class Mypoint {
      @required int user_id;
       @required int mall_id;
      @required String name;
      @required String point;

   Mypoint({required this.user_id,required this.mall_id,required this.name,required this.point});
       factory Mypoint.fromMap(Map<String,dynamic> e) {
    return Mypoint(user_id:e["user_id"].hashCode,mall_id:e["mall_id"].hashCode,name:e["mall_name"],point:e["totalMall"]);
  }
}






















/*class Points extends StatelessWidget {
  final int user_id;

  const Points(  this.user_id) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Points"),
      ),
      body: Center(
        child: Container(
          child:Text("My points:{$pointNumber}",style: Theme.of(context).textTheme.headline6,)
        ),
      ),
    );
  }
}*/




