import 'dart:convert';

LoginResModel loginResModelFromJson(String str) => LoginResModel.fromJson(json.decode(str));
String loginResModelToJson(LoginResModel data) => json.encode(data.toJson());
class LoginResModel {
  LoginResModel({
      this.refresh, 
      this.access, 
      this.id, 
      this.name, 
      this.email, 
      this.phone, 
      this.image, 
      this.alternativePhone, 
      this.travelType, 
      this.language, 
      this.idProof, 
      this.groupSize, 
      this.budget, 
      this.fromDate, 
      this.toDate,});

  LoginResModel.fromJson(dynamic json) {
    refresh = json['refresh'];
    access = json['access'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    alternativePhone = json['alternative_phone'];
    travelType = json['travel_type'];
    language = json['language'];
    idProof = json['id_proof'];
    groupSize = json['group_size'];
    budget = json['budget'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }
  String? refresh;
  String? access;
  num? id;
  String? name;
  String? email;
  num? phone;
  String? image;
  num? alternativePhone;
  String? travelType;
  String? language;
  String? idProof;
  num? groupSize;
  num? budget;
  String? fromDate;
  String? toDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['refresh'] = refresh;
    map['access'] = access;
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['image'] = image;
    map['alternative_phone'] = alternativePhone;
    map['travel_type'] = travelType;
    map['language'] = language;
    map['id_proof'] = idProof;
    map['group_size'] = groupSize;
    map['budget'] = budget;
    map['from_date'] = fromDate;
    map['to_date'] = toDate;
    return map;
  }

}