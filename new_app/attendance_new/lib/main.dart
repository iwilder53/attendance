import 'package:attendance_new/providers/lectures_provider.dart';
import 'package:attendance_new/providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navigation/navigationService.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.orange,
            
          ),
          onGenerateRoute: generateRoute,
          home: const SplashScreen()),
    );
  }
}
