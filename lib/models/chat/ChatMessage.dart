import 'Sender.dart';
import 'dart:convert';

ChatMessage chatMessageFromJson(String str) => ChatMessage.fromJson(json.decode(str));
String chatMessageToJson(ChatMessage data) => json.encode(data.toJson());
class ChatMessage {
  ChatMessage({
      this.id, 
      this.sender, 
      this.content, 
      this.timestamp, 
      this.isRead,});

  ChatMessage.fromJson(dynamic json) {
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