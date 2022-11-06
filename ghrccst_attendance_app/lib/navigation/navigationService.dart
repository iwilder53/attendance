// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ghrccst_attendance_app/main_screen.dart';
import 'package:ghrccst_attendance_app/screens/login.dart';
import 'package:ghrccst_attendance_app/screens/register.dart';
import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NamedRoute.homeScreen:
      return _getPageRoute(const MyHomePage(
        title: 'Welcome Back',
      ));
    case NamedRoute.registerScreen:
      return _getPageRoute(NewStudentScreen());
    default:
      return _getPageRoute(const LoginScreen());
  }
}

PageRoute _getPageRoute(Widget screen) {
  return MaterialPageRoute(builder: (context) => screen);
}
