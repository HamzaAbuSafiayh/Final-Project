import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/components/my_button.dart';
import 'package:finalproject/components/my_textfield.dart';
import 'package:finalproject/pages/homepage.dart';
import 'package:finalproject/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  Uint8List? _image;

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void register() async {
    // Check if the passwords match
    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context); // Dismiss the loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Register user with Firebase Auth
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Use default image URL if no image is selected
      String imageUrl;
      if (_image == null) {
        imageUrl =
            'https://static-00.iconduck.com/assets.00/profile-default-icon-2048x2045-u3j7s5nj.png';
      } else {
        // Upload image to Firebase Storage and get the URL
        imageUrl = await uploadImageToFirebase(_image);
      }

      // Save user details to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'username': usernameController.text,
        'email': emailController.text,
        'imageUrl': imageUrl,
        'role': 'customer', // Set the user role to 'customer'
      });

      // Dismiss the loading dialog and navigate to the home page
      if (mounted) {
        Navigator.pop(context); // Dismiss the loading dialog
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        ); // Navigate to home page or other suitable page
      }
    } catch (e) {
      // Handle registration error
      if (mounted) {
        Navigator.pop(context); // Dismiss the loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<String> uploadImageToFirebase(Uint8List? imageData) async {
    if (imageData == null) throw 'No image selected';
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('userImages/${DateTime.now().millisecondsSinceEpoch}');
    UploadTask uploadTask = ref.putData(imageData);
    TaskSnapshot snapshot = await uploadTask;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('A P P N A M E', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 50),
                  Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : const CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  'https://static-00.iconduck.com/assets.00/profile-default-icon-2048x2045-u3j7s5nj.png'),
                            ),
                      Positioned(
                          left: 80,
                          bottom: -10,
                          child: IconButton(
                              onPressed: selectImage,
                              icon: const Icon(Icons.add_a_photo)))
                    ],
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                      hintText: 'Username',
                      obscureText: false,
                      controller: usernameController),
                  const SizedBox(height: 10),
                  MyTextField(
                      hintText: 'Email',
                      obscureText: false,
                      controller: emailController),
                  const SizedBox(height: 10),
                  MyTextField(
                      hintText: 'Password',
                      obscureText: true,
                      controller: passwordController),
                  const SizedBox(height: 10),
                  MyTextField(
                      hintText: 'Confirm Password',
                      obscureText: true,
                      controller: confirmPasswordController),
                  const SizedBox(height: 25),
                  MyButton(
                    text: 'Register',
                    onTap: () {
                      register();
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Already Have an Account?',
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          ' Login Here',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
