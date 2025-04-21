import 'dart:convert';

ChatRoom chatRoomFromJson(String str) => ChatRoom.fromJson(json.decode(str));
String chatRoomToJson(ChatRoom data) => json.encode(data.toJson());
class ChatRoom {
  ChatRoom({
      this.id, 
      this.name, 
      this.roomType, 
      this.createdAt, 
      this.description, 
      this.trip,});

  ChatRoom.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    roomType = json['room_type'];
    createdAt = json['created_at'];
    description = json['description'];
    trip = json['trip'];
  }
  num? id;
  String? name;
  String? roomType;
  String? createdAt;
  String? description;
  num? trip;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['room_type'] = roomType;
    map['created_at'] = createdAt;
    map['description'] = description;
    map['trip'] = trip;
    return map;
  }

}