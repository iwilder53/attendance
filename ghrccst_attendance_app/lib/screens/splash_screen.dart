import 'package:flutter/material.dart';
import 'package:attendance_new/providers/student_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigation/navigators.dart';
import '../navigation/routes.dart';
import '../providers/lectures_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? phone;

  void loginFromSavedData(phone) async {
    final studentProvider =
        Provider.of<StudentProvider>(context, listen: false);
    bool loginState = await studentProvider.login(int.parse(phone));
    if (loginState == true) {
      await Provider.of<LecturesProvider>(context, listen: false)
          // ignore: use_build_context_synchronously
          .fetchAndSetLectures(
              Provider.of<StudentProvider>(context, listen: false));
      pushReplacement(context, NamedRoute.homeScreen);
    }
  }

  fetchCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('phone');
    if (login != null) {
      phone = login;
      loginFromSavedData(phone);
      return;
    }
    push(context, NamedRoute.loginScreen);
  }

  @override
  void initState() {
    fetchCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("logo.png"),
          const Text('GHRCCST Attendance App'),
        ],
      )),
    );
  }
}
