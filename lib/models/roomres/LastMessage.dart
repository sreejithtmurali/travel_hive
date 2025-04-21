import 'Sender.dart';
import 'dart:convert';

LastMessage lastMessageFromJson(String str) => LastMessage.fromJson(json.decode(str));
String lastMessageToJson(LastMessage data) => json.encode(data.toJson());
class LastMessage {
  LastMessage({
      this.id, 
      this.sender, 
      this.content, 
      this.timestamp, 
      this.isRead,});

  LastMessage.fromJson(dynamic json) {
    id = json['id'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    content = json['content'];
    timestamp = json['timestamp'];
    isRead = json['is_read'];
  }
  num? id;
  Sender? sender;
  String? content;
  String? timestamp;
  bool? isRead;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (sender != null) {
      map['sender'] = sender?.toJson();
    }
    map['content'] = content;
    map['timestamp'] = timestamp;
    map['is_read'] = isRead;
    return map;
  }

}