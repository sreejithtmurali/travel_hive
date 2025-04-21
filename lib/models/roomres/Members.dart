import 'dart:convert';

Members membersFromJson(String str) => Members.fromJson(json.decode(str));
String membersToJson(Members data) => json.encode(data.toJson());
class Members {
  Members({
      this.id, 
      this.room, 
      this.user, 
      this.username, 
      this.isAdmin, 
      this.joinedAt,});

  Members.fromJson(dynamic json) {
    id = json['id'];
    room = json['room'];
    user = json['user'];
    username = json['username'];
    isAdmin = json['is_admin'];
    joinedAt = json['joined_at'];
  }
  num? id;
  num? room;
  num? user;
  String? username;
  bool? isAdmin;
  String? joinedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['room'] = room;
    map['user'] = user;
    map['username'] = username;
    map['is_admin'] = isAdmin;
    map['joined_at'] = joinedAt;
    return map;
  }

}