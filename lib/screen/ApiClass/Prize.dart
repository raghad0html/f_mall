      import 'package:flutter/cupertino.dart';

class Prize {
  @required int prod_id;
  @required String name;
  @required String icon;
  @required String count;

   Prize({required this.prod_id,required this.name,required this.count,required this.icon});
         factory Prize.fromMap(Map<String,dynamic> e) {
    return Prize(prod_id:e["prod_id"].hashCode,name:e["name"],icon:e["icon"],count:e["count"]);
  }
}