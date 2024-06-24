import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finalproject/view_models/profile_cubit/profile_cubit.dart';

class ChatListItem extends StatelessWidget {
  final String userId;
  final String receiverId;

  const ChatListItem({
    super.key,
    required this.userId,
    required this.receiverId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = ProfileCubit();
        cubit.getProfileWorker(receiverId);
        return cubit;
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileInitial) {
            return const Center(child: SizedBox());
          } else if (state is ProfileLoaded) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(state.profile.imageUrl),
              ),
              title: Text(
                state.profile.username,
                textAlign: TextAlign.left,
              ),
              onTap: () {
                Navigator.of(context).pushNamed(
                  '/chat',
                  arguments: {
                    'userid': userId,
                    'workerid': receiverId,
                  },
                );
              },
            );
          } else if (state is ProfileError) {
            return const Center(child: Text('Error loading profile'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
