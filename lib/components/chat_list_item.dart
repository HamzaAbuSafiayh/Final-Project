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
    final theme = Theme.of(context);

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
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.onSurface.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(state.profile.imageUrl),
                ),
                title: Text(
                  state.profile.username,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Last message preview...', // Placeholder for last message
                  style: theme.textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '12:00 PM', // Placeholder for last message time
                      style: theme.textTheme.bodySmall,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4.0),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        '3', // Placeholder for unread message count
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ],
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
              ),
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
