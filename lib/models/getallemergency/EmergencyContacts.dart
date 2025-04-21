import 'Data.dart';
import 'dart:convert';

EmergencyContacts emergencyContactsFromJson(String str) => EmergencyContacts.fromJson(json.decode(str));
String emergencyContactsToJson(EmergencyContacts data) => json.encode(data.toJson());
class EmergencyContacts {
  EmergencyContacts({
      this.status, 
      this.data,});

  EmergencyContacts.fromJson(dynamic json) {
    status = json['Status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(EmerContact.fromJson(v));
      });
    }
  }
  String? status;
  List<EmerContact>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}