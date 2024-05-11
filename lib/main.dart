import 'package:finalproject/auth/login_or_register.dart';
import 'package:finalproject/firebase_options.dart';
import 'package:finalproject/theme/dark_mode.dart';
import 'package:finalproject/theme/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Handyman',
      theme: lightMode,
      darkTheme: darkMode,
      home: const LoginOrRegister(),
    );
  }
}
