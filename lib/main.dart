import 'package:finalproject/auth/auth.dart';
import 'package:finalproject/firebase_options.dart';
import 'package:finalproject/routes/app_router.dart';
import 'package:finalproject/theme/dark_mode.dart';
import 'package:finalproject/theme/light_mode.dart';
import 'package:finalproject/view_models/auth_cubit/auth_cubit.dart';
import 'package:finalproject/view_models/credit_card_cubit/credit_card_cubit.dart';
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
            final cubit = AuthCubit();
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final cubit = CreditCardCubit();
            return cubit;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        title: 'Handyman',
        theme: lightMode,
        darkTheme: darkMode,
        home: const AuthPage(),
      ),
    );
  }
}
