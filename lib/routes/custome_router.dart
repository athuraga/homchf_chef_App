import 'package:flutter/material.dart';
import 'package:homchf_chef_side/routes/route_names.dart';
import 'package:homchf_chef_side/screens/MainScreen.dart';
import 'package:homchf_chef_side/screens/auth/LoginScreen.dart';
import 'package:homchf_chef_side/screens/auth/RegisterScreen.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => MainScreen());
      // case photosRoute:
      //Albums? albums = routeSettings.arguments as Albums;
      // return MaterialPageRoute(builder: (_) => photosScreen(albums: albums));
    }
    return MaterialPageRoute(builder: (_) => LoginScreen());
  }
}
