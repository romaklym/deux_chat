import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deux_chat/model/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  // get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Send invitation
  Future<void> sendInvitation(String receiverId) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    // Construct invitation object
    Map<String, dynamic> invitationData = {
      'senderId': currentUserId,
      'receiverId': receiverId,
      'timestamp': timestamp,
      'accepted': false, // Invitation starts as not accepted
    };

    // Add invitation to the database
    await _fireStore.collection('invitations').add(invitationData);
  }

  // Accept invitation and create chat room
  Future<void> acceptInvitation(String invitationId) async {
    final DocumentSnapshot invitationSnapshot =
        await _fireStore.collection('invitations').doc(invitationId).get();

    if (invitationSnapshot.exists) {
      final Map<String, dynamic> invitationData =
          invitationSnapshot.data() as Map<String, dynamic>;

      if (invitationData['accepted'] == false) {
        final String senderId = invitationData['senderId'];
        final String receiverId = invitationData['receiverId'];

        // Mark invitation as accepted
        await _fireStore
            .collection('invitations')
            .doc(invitationId)
            .update({'accepted': true});

        // Create a chat room
        List<String> ids = [senderId, receiverId];
        ids.sort();
        String chatRoomId = ids.join("_");

        // Add users to the chat room
        await _fireStore.collection('chat_rooms').doc(chatRoomId).set({
          'users': [senderId, receiverId],
        });
      }
    }
  }

  // send message
  Future<void> sendMessage(String receiverId, String message) async {
    // get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    // construct chat room id from current user id and receiver id (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // sort the ids (this ensures the chat room id is always the same for any pair of people)
    String chatRoomId = ids.join("_");
    // add new message to the data base
    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    // construct chat room id from current user id and receiver id (sorted to ensure uniqueness)
    List<String> ids = [userId, otherUserId];
    ids.sort(); // sort the ids (this ensures the chat room id is always the same for any pair of people)
    String chatRoomId = ids.join("_");
    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
