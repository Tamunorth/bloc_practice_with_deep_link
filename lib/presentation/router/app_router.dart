import 'package:flutter/material.dart';
import 'package:flutter_bloc_concepts/presentation/screens/home_screen.dart';
import 'package:flutter_bloc_concepts/presentation/screens/second_screen.dart';
import 'package:flutter_bloc_concepts/presentation/screens/third_screen.dart';

class RoutingConstants {
  static const String homeScreenRoute = '/';
  static const String secondScreenRoute = '/second';
  static const String thirdScreenRoute = '/third';
}

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    final GlobalKey<ScaffoldState> key = settings.arguments;
    switch (settings.name) {
      case RoutingConstants.homeScreenRoute:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
            title: "Home Screen",
            color: Colors.blueAccent,
          ),
        );
      case RoutingConstants.secondScreenRoute:
        return MaterialPageRoute(
          builder: (_) => SecondScreen(
            title: "Second Screen",
            color: Colors.redAccent,
          ),
        );
      case RoutingConstants.thirdScreenRoute:
        return MaterialPageRoute(
          builder: (_) => ThirdScreen(
            title: "Third Screen",
            color: Colors.redAccent,
          ),
        );
      default:
        return null;
    }
  }
}
