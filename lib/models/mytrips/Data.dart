import 'ChatRoom.dart';
import 'dart:convert';

MyTrip MyTripFromJson(String str) => MyTrip.fromJson(json.decode(str));
String MyTripToJson(MyTrip MyTrip) => json.encode(MyTrip.toJson());
class MyTrip {
  MyTrip({
      this.id, 
      this.chatRoom, 
      this.tripName, 
      this.location, 
      this.description, 
      this.travelType, 
      this.groupSize, 
      this.availableSeat, 
      this.budget, 
      this.fromDate, 
      this.toDate, 
      this.image, 
      this.user,});

  MyTrip.fromJson(dynamic json) {
    id = json['id'];
    chatRoom = json['chat_room'] != null ? ChatRoom.fromJson(json['chat_room']) : null;
    tripName = json['trip_name'];
    location = json['location'];
    description = json['description'];
    travelType = json['travel_type'];
    groupSize = json['group_size'];
    availableSeat = json['available_seat'];
    budget = json['budget'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    image = json['image'];
    user = json['user'];
  }
  num? id;
  ChatRoom? chatRoom;
  String? tripName;
  String? location;
  String? description;
  String? travelType;
  num? groupSize;
  num? availableSeat;
  num? budget;
  String? fromDate;
  String? toDate;
  String? image;
  dynamic user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (chatRoom != null) {
      map['chat_room'] = chatRoom?.toJson();
    }
    map['trip_name'] = tripName;
    map['location'] = location;
    map['description'] = description;
    map['travel_type'] = travelType;
    map['group_size'] = groupSize;
    map['available_seat'] = availableSeat;
    map['budget'] = budget;
    map['from_date'] = fromDate;
    map['to_date'] = toDate;
    map['image'] = image;
    map['user'] = user;
    return map;
  }

}