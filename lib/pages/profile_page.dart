import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/components/profile_page_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    return userData;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else {
          Map<String, dynamic>? userData = snapshot.data!.data();
          return Scaffold(
            body: Column(
              children: [
                const SizedBox(height: 150),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(userData!['image_url']),
                ),
                const SizedBox(height: 10),
                Text(
                  userData['username'],
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  userData['email'],
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
        }
      },
    );
  }
}
