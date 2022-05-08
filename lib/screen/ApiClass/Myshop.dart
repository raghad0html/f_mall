    import 'package:flutter/cupertino.dart';

class Myshop {
      @required int shop_id;
      @required String name;
      @required String icon;

   Myshop({required this.shop_id,required this.name,required this.icon});
       factory Myshop.fromMap(Map<String,dynamic> e) {
    return Myshop(shop_id:e["shop_id"].hashCode,name:e["name"],icon:e["icon"]);
  }
}
