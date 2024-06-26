// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:finalproject/components/my_button.dart';
import 'package:finalproject/components/my_textfield.dart';
import 'package:finalproject/pages/homepage.dart';
import 'package:finalproject/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:finalproject/view_models/auth_cubit/auth_cubit.dart';

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
  final String defaultImageUrl =
      'https://static-00.iconduck.com/assets.00/profile-default-icon-2048x2045-u3j7s5nj.png';

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void register() async {
    final username = usernameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (email.isEmpty ||
        password.isEmpty ||
        username.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }
    String imageUrl;
    if (_image == null) {
      imageUrl = defaultImageUrl;
    } else {
      imageUrl = await uploadImageToFirebase(_image);
    }

    context
        .read<AuthCubit>()
        .signUpWithEmailAndPassword(email, password, username, imageUrl);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Registering..."),
              ],
            ),
          ),
        );
      },
    );
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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        if (state is AuthSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: SafeArea(
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
                      onTap: register,
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
      ),
    );
  }
}
