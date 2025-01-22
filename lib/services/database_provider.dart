import 'package:chatter/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseProvider extends ChangeNotifier {
  final db = FirebaseFirestore.instance;

  List<Message> messages = [];

  DatabaseProvider() {
    loadMessage();
  }

  loadMessage() {
    final docRef = db.collection('chats').doc('room1').collection('messages');
    docRef.orderBy('dateTime').snapshots().listen((event) {
      messages = event.docs.map((e) => Message.fromFirestore(e, null)).toList();
      notifyListeners();
    });
  }

  addMessage(String content) async {
    var message = Message(
      content: content,
      uid: FirebaseAuth.instance.currentUser!.uid,
      dateTime: DateTime.now(),
    );

    await db
        .collection('chats')
        .doc('room1')
        .collection('messages')
        .add(message.toFirestore());
    notifyListeners();
  }
}
