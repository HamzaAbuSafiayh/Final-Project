import 'package:finalproject/models/chatroom_model.dart';
import 'package:finalproject/routes/api_paths.dart';
import 'package:finalproject/services/firestore_services.dart';

abstract class ChatRoomServices {
  Future<List<ChatRoomModel>> getChatRooms(String userId);
  final firestoreServices = FirestoreService.instance;
}

class ChatRoomServicesImpl extends ChatRoomServices {
  @override
   Future<List<ChatRoomModel>> getChatRooms(String userId) async {
    final chatRooms = await firestoreServices.getCollection(
      path: ApiPaths.chatRooms(),
      builder: (data, documentId) => ChatRoomModel.fromMap(data),
    );

    // Filter chat rooms to include only those involving the current user
    return chatRooms.where((chatRoom) => chatRoom.users.contains(userId)).toList();
  }
}
