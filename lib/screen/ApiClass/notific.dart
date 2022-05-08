  import 'package:flutter/cupertino.dart';

class notific {
      @required String ?mall_name;
      @required String ?text;
      @required String ?icon;

        notific({
          required this.mall_name,
         required this.text,
          required this.icon
        });
        factory notific.fromMap(Map<String,dynamic> e) {
    return notific(mall_name:e["mall_name"],text:e["text"],icon:e["icon"]);
  }
}