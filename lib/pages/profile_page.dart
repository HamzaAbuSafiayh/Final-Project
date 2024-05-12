import 'package:finalproject/components/profile_page_fields.dart';
import 'package:finalproject/view_models/profile_cubit/profile_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitial) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is ProfileLoaded) {
          return Scaffold(
            body: Column(
              children: [
                const SizedBox(height: 150),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(state.profile.imageUrl),
                ),
                const SizedBox(height: 10),
                Text(
                  state.profile.username,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  state.profile.email,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileField(
                      icon: Icon(Icons.notifications),
                      title: 'Notifications',
                    ),
                    ProfileField(
                      icon: Icon(Icons.favorite),
                      title: 'Favorites',
                    ),
                    ProfileField(
                      icon: Icon(Icons.shopping_cart),
                      title: 'Cart',
                    ),
                    ProfileField(
                      icon: Icon(Icons.settings),
                      title: 'Settings',
                    ),
                    ProfileField(
                      icon: Icon(Icons.help),
                      title: 'Help',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onPressed: () {
                    logout();
                  },
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      },
    );
  }
}
