       import 'package:flutter/cupertino.dart';

class Myprod {
  @required int prod_id;
  @required String name;
  @required String icon;
  @required String price;

   Myprod({required this.prod_id,required this.name,required this.price,required this.icon});
         factory Myprod.fromMap(Map<String,dynamic> e) {
    return Myprod(prod_id:e["prod_id"].hashCode,name:e["name"],icon:e["icon"],price:e["price"]);
  }
}
