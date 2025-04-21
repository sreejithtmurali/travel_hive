import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.id, 
      this.name, 
      this.phone, 
      this.email, 
      this.alternativePhone, 
      this.image, 
      this.travelType, 
      this.language, 
      this.idProof, 
      this.budget, 
      this.groupSize, 
      this.fromDate, 
      this.toDate,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    alternativePhone = json['alternative_phone'];
    image = json['image'];
    travelType = json['travel_type'];
    language = json['language'];
    idProof = json['id_proof'];
    budget = json['budget'];
    groupSize = json['group_size'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }
  num? id;
  String? name;
  num? phone;
  String? email;
  num? alternativePhone;
  dynamic image;
  String? travelType;
  String? language;
  dynamic idProof;
  num? budget;
  num? groupSize;
  String? fromDate;
  String? toDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    map['alternative_phone'] = alternativePhone;
    map['image'] = image;
    map['travel_type'] = travelType;
    map['language'] = language;
    map['id_proof'] = idProof;
    map['budget'] = budget;
    map['group_size'] = groupSize;
    map['from_date'] = fromDate;
    map['to_date'] = toDate;
    return map;
  }

}