import 'Data.dart';
import 'dart:convert';

MytripsResModelDart mytripsResModelDartFromJson(String str) => MytripsResModelDart.fromJson(json.decode(str));
String mytripsResModelDartToJson(MytripsResModelDart data) => json.encode(data.toJson());
class MytripsResModelDart {
  MytripsResModelDart({
      this.msg, 
      this.data,});

  MytripsResModelDart.fromJson(dynamic json) {
    msg = json['Msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(MyTrip.fromJson(v));
      });
    }
  }
  String? msg;
  List<MyTrip>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Msg'] = msg;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}