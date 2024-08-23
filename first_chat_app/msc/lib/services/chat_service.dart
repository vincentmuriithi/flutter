import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

import "../models/message.dart";

class ChatService {
  // get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //send message
Future<void> sendMessage(String receiverID, message) async {
//get current user info
  final String currentUserID = _auth.currentUser!.uid;
  final String currentUserEmail = _auth.currentUser!.email!;
  final Timestamp timestamp = Timestamp.now();
//create a new message
  Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp
  );
//construct a chat room ID for the two users sorted(to ensure uniqueness)
  List<String> ids = [currentUserID, receiverID];
  ids.sort(); //sort the ids (this ensures the chatRoomID  is the same for any 2 people)\
  String chatRoomID = ids.join("_");

// add new message to the
  await _firestore
      .collection("chat_rooms")
      .doc(chatRoomID)
      .collection("messages")
      .add(newMessage.toMap());
}
//get message
Stream<QuerySnapshot> getMessages(String userID, otherUserID){
//construct a chatroomID for the two users
List<String> ids = [userID, otherUserID];
ids.sort();
String chatRoomID = ids.join("_");
return _firestore
    .collection("chat_rooms")
    .doc(chatRoomID)
    .collection("messages")
    .orderBy("timestamp", descending: false)
    .snapshots();
}
}

