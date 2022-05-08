     import 'package:flutter/cupertino.dart';

class comp {
  @required int prod_id;
  @required String name;
  @required String icon;
  @required String count;

   comp({required this.prod_id,required this.name,required this.count,required this.icon});
         factory comp.fromMap(Map<String,dynamic> e) {
    return comp(prod_id:e["prod_id"].hashCode,name:e["name"],icon:e["icon"],count:e["count"]);
  }
}