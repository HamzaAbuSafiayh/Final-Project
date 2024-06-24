import 'package:finalproject/components/profile_page_fields.dart';
import 'package:finalproject/routes/app_routes.dart';
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
          List<Widget> profileFields = [
            ProfileField(
              onTap: () {},
              icon: Icon(
                Icons.notifications,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: 'Notifications',
            ),
            ProfileField(
              onTap: () {},
              icon: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: 'Favorites',
            ),
            ProfileField(
              onTap: () {},
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: 'Cart',
            ),
            ProfileField(
              onTap: () {},
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: 'Settings',
            ),
            ProfileField(
              onTap: () {},
              icon: Icon(
                Icons.help,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: 'Help',
            ),
          ];

          // Adding the Tasks field if the user role is 'worker'
          if (state.profile.role == 'worker') {
            profileFields.add(ProfileField(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.tasks);
              },
              icon: Icon(
                Icons.work,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: 'Tasks',
            ));
          }

          return Scaffold(
            body: Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.inversePrimary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 120),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(state.profile.imageUrl),
                      backgroundColor: Colors.white,
                      child: state.profile.imageUrl.isEmpty
                          ? Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey[400],
                            )
                          : null,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      state.profile.username,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                    ),
                    Text(
                      state.profile.email,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                        ),
                        onPressed: () {},
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        children: profileFields,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                        ),
                        onPressed: () {
                          logout();
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('Error loading profile'),
          );
        }
      },
    );
  }
}
