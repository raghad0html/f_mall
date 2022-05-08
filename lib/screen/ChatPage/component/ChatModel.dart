

import 'dart:io';

import 'package:flutter/cupertino.dart';

class chatModel{
   @required int mall_id;
  @required String name;
  @required String icon;
  @required bool isGroup;
  @required String time;
  @required String currentMessage;
  @required  String status;
  @required  bool select =false;

  chatModel({required this.mall_id,required this.name,required this.icon,required this.isGroup,required this.time,required this.currentMessage,required this.status,this.select=false});
    factory chatModel.fromMap(Map<String,dynamic> e) {
        return chatModel(mall_id: e["mall_id"],name:e["name"],icon:e["icon"],isGroup:true,time:"",currentMessage:e["link_app"],status:"",select:false);
      }


}