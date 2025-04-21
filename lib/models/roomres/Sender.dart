import 'dart:convert';

Sender senderFromJson(String str) => Sender.fromJson(json.decode(str));
String senderToJson(Sender data) => json.encode(data.toJson());
class Sender {
  Sender({
      this.id, 
      this.name, 
      this.email, 
      this.phone, 
      this.image,});

  Sender.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
  }
  num? id;
  String? name;
  String? email;
  num? phone;
  dynamic image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['image'] = image;
    return map;
  }

}