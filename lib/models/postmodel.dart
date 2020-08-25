import 'package:flutter/foundation.dart';

class PostModel{
  String postid;
  String posttitle;
  String postdesc;
  String imglink;

  PostModel({this.postid,this.posttitle,this.postdesc,this.imglink});
  toMap(){
    Map<String,dynamic>map = Map();
    map['postid']=postid;
    map['posttitle'] =posttitle;
    map['postdesc'] =postdesc;
    map['imglink'] =imglink;
    return map;

  }
}

