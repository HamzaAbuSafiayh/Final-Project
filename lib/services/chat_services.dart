import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/models/message_model.dart';
import 'package:finalproject/routes/api_paths.dart';
import 'package:finalproject/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class ChatService {
  Future<void> accessChat(String userId, String workerId);
  Future<List<MessageModel>> getMessages(String userId, String workerId);
  Future<void> sendMessage(String userId, String workerId, String content);

  final user = FirebaseAuth.instance.currentUser;
  final firestoreservices = FirestoreService.instance;
}

class ChatServicesImpl extends ChatService {
  @override
  Future<void> accessChat(String userId, String workerId) async {
    final chatResult = await firestoreservices.getCollection(
        path: ApiPaths.messages(
          userId,
          workerId,
        ),
        builder: (data, documentId) => MessageModel.fromMap(data));
    if (chatResult.isEmpty) {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc('${userId}_$workerId')
          .set({
        'users': [userId, workerId],
      });
    }
  }

  @override
  Future<List<MessageModel>> getMessages(String userId, String workerId) async {
    final messagesSnapshot = await FirebaseFirestore.instance
        .collection(ApiPaths.messages(userId, workerId))
        .orderBy('timestamp')
        .get();

    return messagesSnapshot.docs
        .map((doc) => MessageModel.fromMap(doc.data()))
        .toList();
  }

  @override
  Future<void> sendMessage(
      String userId, String workerId, String content) async {
    final message = {
      'senderId': userId,
      'message': content,
      'timestamp': DateTime.now().toIso8601String(),
    };

    try {
      // Check if the chat room exists in the first path
      var firstPathSnapshot = await FirebaseFirestore.instance
          .collection(ApiPaths.messages(userId, workerId))
          .limit(1)
          .get();

      // Determine the correct path based on the presence of data
      String correctPath;
      if (firstPathSnapshot.docs.isNotEmpty) {
        correctPath = ApiPaths.messages(userId, workerId);
      } else {
        // Check the second path if the first one is empty
        var secondPathSnapshot = await FirebaseFirestore.instance
            .collection(ApiPaths.messages(workerId, userId))
            .limit(1)
            .get();

        if (secondPathSnapshot.docs.isNotEmpty) {
          correctPath = ApiPaths.messages(workerId, userId);
        } else {
          // If neither path has data, default to the first path
          correctPath = ApiPaths.messages(userId, workerId);
        }
      }

      // Send the message to the determined path
      await FirebaseFirestore.instance.collection(correctPath).add(message);
    } catch (e) {
      debugPrint('Error sending message: $e');
    }
  }
}
