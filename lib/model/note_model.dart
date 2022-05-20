import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String? id;
  String? title;
  String? content;
  int? colorNumber;
  Timestamp? timestamp;
  String? userId;
  String? userName;
  List? sharedWithUsers;

  Note({
    this.title,
    this.content,
    this.timestamp,
    this.colorNumber,
    this.id,
    this.sharedWithUsers,
    this.userId,
    this.userName,
  });

  Note.fromJson(DocumentSnapshot data) {
    id = data.id;
    title = data['note_title'];
    content = data['note_content'];
    colorNumber = data['color_id'];
    timestamp = data['creation_date'];
    userId = data['user_id'];
    userName = data['user_name'];
    sharedWithUsers = data['share_with_users'];
  }
}
