import 'Members.dart';
import 'LastMessage.dart';
import 'dart:convert';

RoomsRes roomsResFromJson(String str) => RoomsRes.fromJson(json.decode(str));
String roomsResToJson(RoomsRes data) => json.encode(data.toJson());
class RoomsRes {
  RoomsRes({
      this.id, 
      this.name, 
      this.roomType, 
      this.description, 
      this.createdAt, 
      this.members, 
      this.lastMessage, 
      this.unreadCount,});

  RoomsRes.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    roomType = json['room_type'];
    description = json['description'];
    createdAt = json['created_at'];
    if (json['members'] != null) {
      members = [];
      json['members'].forEach((v) {
        members?.add(Members.fromJson(v));
      });
    }
    lastMessage = json['last_message'] != null ? LastMessage.fromJson(json['last_message']) : null;
    unreadCount = json['unread_count'];
  }
  num? id;
  String? name;
  String? roomType;
  dynamic description;
  String? createdAt;
  List<Members>? members;
  LastMessage? lastMessage;
  num? unreadCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['room_type'] = roomType;
    map['description'] = description;
    map['created_at'] = createdAt;
    if (members != null) {
      map['members'] = members?.map((v) => v.toJson()).toList();
    }
    if (lastMessage != null) {
      map['last_message'] = lastMessage?.toJson();
    }
    map['unread_count'] = unreadCount;
    return map;
  }

}