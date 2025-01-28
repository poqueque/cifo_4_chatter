import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Message implements Comparable<Message> {
  final String uid;
  final String userName;
  final String content;
  final DateTime dateTime;

  bool get isMine => (uid == FirebaseAuth.instance.currentUser?.uid);

  Message({
    required this.content,
    required this.uid,
    required this.userName,
    required this.dateTime,
  });

  factory Message.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Message(
      content: data?['content'] ?? "",
      uid: data?['uid'] ?? "",
      userName: data?['user_name'] ?? "Anònim",
      dateTime: DateTime.fromMillisecondsSinceEpoch(data?['dateTime'] ?? 0),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "content": content,
      "uid": uid,
      "user_name": userName,
      "dateTime": dateTime.millisecondsSinceEpoch,
    };
  }

  @override
  int compareTo(Message other) {
    return dateTime.compareTo(other.dateTime);
  }
}
