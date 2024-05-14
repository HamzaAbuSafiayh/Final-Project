import 'package:finalproject/auth/auth.dart';
import 'package:finalproject/firebase_options.dart';
import 'package:finalproject/theme/dark_mode.dart';
import 'package:finalproject/theme/light_mode.dart';
import 'package:finalproject/view_models/workers_cubit/workers_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = WorkersCubit();
            cubit.getWorkers();
            return cubit;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Handyman',
        theme: lightMode,
        darkTheme: darkMode,
        home: const AuthPage(),
      ),
    );
  }
}
