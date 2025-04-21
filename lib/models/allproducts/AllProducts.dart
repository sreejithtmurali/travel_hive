import 'Data.dart';
import 'dart:convert';

AllProducts allProductsFromJson(String str) => AllProducts.fromJson(json.decode(str));
String allProductsToJson(AllProducts data) => json.encode(data.toJson());
class AllProducts {
  AllProducts({
      this.msg,
      this.data,});

  AllProducts.fromJson(dynamic json) {
    msg = json['Msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Products.fromJson(v));
      });
    }
  }
  String? msg;
  List<Products>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Msg'] = msg;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}