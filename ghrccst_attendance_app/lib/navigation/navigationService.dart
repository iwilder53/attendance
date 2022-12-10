// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ghrccst_attendance_app/screens/main_screen.dart';
import 'package:ghrccst_attendance_app/navigation/arguments.dart';
import 'package:ghrccst_attendance_app/screens/login.dart';
import 'package:ghrccst_attendance_app/screens/login_demo.dart';
import 'package:ghrccst_attendance_app/screens/profile_page.dart';
import 'package:ghrccst_attendance_app/screens/register.dart';
import 'package:ghrccst_attendance_app/screens/timetable_screen.dart';
import '../screens/otp_screen.dart';
import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NamedRoute.homeScreen:
      return _getPageRoute(const MyHomePage(
        title: 'GHRCCST Demo',
      ));
    case NamedRoute.otpScreen:
      return _getPageRoute(
        OtpScreen(args: settings.arguments as OtpScreenArguments),
      );

    case NamedRoute.profilePage:
      return _getPageRoute(const ProfilePage());
    case NamedRoute.loginScreenDemo:
      return _getPageRoute(const LoginScreenDemo());
    case NamedRoute.timeTableScreen:
      return _getPageRoute(const TimeTableScreen());
    case NamedRoute.registerScreen:
      return _getPageRoute(NewStudentScreen());
    default:
      return _getPageRoute(LoginScreen());
  }
}

PageRoute _getPageRoute(Widget screen) {
  return MaterialPageRoute(builder: (context) => screen);
}
