import 'dart:convert';

EmerContact EmerContactFromJson(String str) => EmerContact.fromJson(json.decode(str));
String EmerContactToJson(EmerContact EmerContact) => json.encode(EmerContact.toJson());
class EmerContact {
  EmerContact({
      this.id, 
      this.user, 
      this.name, 
      this.relationship, 
      this.phone, 
      this.email, 
      this.priority, 
      this.createdAt,});

  EmerContact.fromJson(dynamic json) {
    id = json['id'];
    user = json['user'];
    name = json['name'];
    relationship = json['relationship'];
    phone = json['phone'];
    email = json['email'];
    priority = json['priority'];
    createdAt = json['created_at'];
  }
  num? id;
  String? user;
  String? name;
  String? relationship;
  num? phone;
  String? email;
  String? priority;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user'] = user;
    map['name'] = name;
    map['relationship'] = relationship;
    map['phone'] = phone;
    map['email'] = email;
    map['priority'] = priority;
    map['created_at'] = createdAt;
    return map;
  }

}