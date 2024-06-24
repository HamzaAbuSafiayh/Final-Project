import 'dart:async';

import 'package:finalproject/routes/api_paths.dart';
import 'package:finalproject/services/chat_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final chatServices = ChatServicesImpl();
  StreamSubscription? _chatSubscription;

  void getMessages(String userId, String workerId) async {
    emit(ChatLoading());
    try {
      _chatSubscription = FirebaseFirestore.instance
          .collection(ApiPaths.messages(userId, workerId))
          .orderBy('timestamp')
          .snapshots()
          .listen((snapshot) {
        final messages = snapshot.docs
            .map((doc) => MessageModel.fromMap(doc.data()))
            .toList();
        emit(ChatLoaded(messages));
      });
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void sendMessage(String userId, String workerId, String content) async {
    try {
      await chatServices.sendMessage(userId, workerId, content);
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    return super.close();
  }
}
