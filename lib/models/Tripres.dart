import 'dart:convert';

Tripres tripresFromJson(String str) => Tripres.fromJson(json.decode(str));
String tripresToJson(Tripres data) => json.encode(data.toJson());
class Tripres {
  Tripres({
      this.data,});

  Tripres.fromJson(dynamic json) {
    data = json['data'];
  }
  String? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    return map;
  }

}