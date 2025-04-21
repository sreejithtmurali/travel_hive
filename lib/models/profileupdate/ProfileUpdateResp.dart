import 'Data.dart';
import 'dart:convert';

ProfileUpdateResp profileUpdateRespFromJson(String str) => ProfileUpdateResp.fromJson(json.decode(str));
String profileUpdateRespToJson(ProfileUpdateResp data) => json.encode(data.toJson());
class ProfileUpdateResp {
  ProfileUpdateResp({
      this.status, 
      this.msg, 
      this.data,});

  ProfileUpdateResp.fromJson(dynamic json) {
    status = json['Status'];
    msg = json['Msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  String? msg;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['Msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}