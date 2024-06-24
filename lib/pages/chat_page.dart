import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject/view_models/chat_cubit/chat_cubit.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final userId = arguments['userid'] as String;
    final workerId = arguments['workerid'] as String;
    final TextEditingController messageController = TextEditingController();

    return BlocProvider(
      create: (context) => ChatCubit()..getMessages(userId, workerId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chat with Worker'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is ChatError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('error')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ChatLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChatLoaded) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        final isSentByMe = message.senderId == userId;

                        return Align(
                          alignment: isSentByMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.75,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSentByMe ? Colors.blue : Colors.grey[300],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              message.message,
                              style: TextStyle(
                                color: isSentByMe ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('Something went wrong!'));
                  }
                },
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    onPressed: () {
                      final content = messageController.text;
                      if (content.isNotEmpty) {
                        context
                            .read<ChatCubit>()
                            .sendMessage(userId, workerId, content);
                        messageController.clear();
                      }
                    },
                    mini: true,
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
