import 'package:finalproject/auth/login_or_register.dart';
import 'package:finalproject/pages/category_workers.dart';
import 'package:finalproject/pages/chat_page.dart';
import 'package:finalproject/pages/completion_page.dart';
import 'package:finalproject/pages/confirmation_page.dart';
import 'package:finalproject/pages/homepage.dart';
import 'package:finalproject/pages/tasker_profile.dart';
import 'package:finalproject/routes/app_routes.dart';
import 'package:finalproject/view_models/chat_cubit/chat_cubit.dart';
import 'package:finalproject/view_models/workers_cubit/workers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.chat:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = ChatCubit();
              return cubit;
            },
            child: const ChatPage(),
          ),
          settings: settings,
        );
      case AppRoutes.completion:
        return MaterialPageRoute(
          builder: (_) => const OrderCompletionPage(),
          settings: settings,
        );
      case AppRoutes.confirmation:
        return MaterialPageRoute(
          builder: (_) => const ConfirmationPage(),
          settings: settings,
        );
      case AppRoutes.workerProfile:
        return MaterialPageRoute(
          builder: (_) => const WorkerProfile(),
          settings: settings,
        );
      case AppRoutes.homeLogin:
        return MaterialPageRoute(
          builder: (_) => const LoginOrRegister(),
          settings: settings,
        );
      case AppRoutes.homePage:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      case AppRoutes.categoryWorkers:
        final category = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = WorkersCubit();
              cubit.getWorkersByCat(category);
              return cubit;
            },
            child: const CategoryWorkers(),
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Error Page!'),
            ),
          ),
        );
    }
  }
}
