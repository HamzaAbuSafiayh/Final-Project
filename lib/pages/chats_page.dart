import 'package:finalproject/components/chat_list_item.dart';
import 'package:finalproject/models/chatroom_model.dart';
import 'package:finalproject/services/chatroom_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatsListPage extends StatelessWidget {
  const ChatsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: FutureBuilder<List<ChatRoomModel>>(
        future: ChatRoomServicesImpl().getChatRooms(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final chatRooms = snapshot.data ?? [];
          if (chatRooms.isEmpty) {
            return const Center(
              child: Text(
                'No chats available',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: chatRooms.length,
            itemBuilder: (context, index) {
              final chatRoom = chatRooms[index];
              final receiverId =
                  chatRoom.users.firstWhere((id) => id != userId);
              return ChatListItem(
                userId: userId,
                receiverId: receiverId,
              );
            },
          );
        },
      ),
    );
  }
}
