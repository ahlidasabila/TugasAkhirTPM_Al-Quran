import 'package:finalproject/components/navbar.dart';
import 'package:finalproject/pages/homepage.dart';
import 'package:finalproject/pages/login.dart';
import 'package:finalproject/pages/register.dart';
import 'package:finalproject/routes/routes.dart';
import 'package:flutter/material.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteGenerator.login:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case RouteGenerator.register:
        return MaterialPageRoute(builder: (_) => RegisterPage());

      case RouteGenerator.homepage:
        return MaterialPageRoute(builder: (_) => Homepage());

      case RouteGenerator.navbar:
        return MaterialPageRoute(builder: (_) => NavBar());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(child: Text('Error page')),
      );
    });
  }
}
