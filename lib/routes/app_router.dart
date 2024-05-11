import 'package:finalproject/auth/login_or_register.dart';
import 'package:finalproject/routes/app_routes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeLogin :
        return MaterialPageRoute(
          builder: (_) =>  const LoginOrRegister(),
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
