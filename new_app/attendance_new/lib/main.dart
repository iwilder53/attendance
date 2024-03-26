import 'dart:convert';

import 'package:attendance_new/providers/lectures_provider.dart';
import 'package:attendance_new/providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:provider/provider.dart';
import 'navigation/navigationService.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/themes/dark.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp(
    theme: theme,
  ));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;

  const MyApp({super.key, required this.theme});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StudentProvider>(
            create: (_) => StudentProvider()),
        ChangeNotifierProvider<LecturesProvider>(
            create: (_) => LecturesProvider()),
      ],
      child: MaterialApp(
          title: 'GHR CCST Attendance Management',
          theme: theme,
          /*  ThemeData(
              primaryColor: Colors.amber,
              useMaterial3: true,
              primarySwatch: Colors.amber,
              textTheme: Typography.whiteMountainView), */
          onGenerateRoute: generateRoute,
          home: const SplashScreen()),
    );
  }
}
