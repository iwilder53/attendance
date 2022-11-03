import 'package:flutter/material.dart';
import 'package:ghrccst_attendance_app/providers/student_provider.dart';
import 'package:ghrccst_attendance_app/screens/login.dart';
import 'package:provider/provider.dart';
import 'main_screen.dart';
import 'providers/bluetooth.dart';

void main() {
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
        ChangeNotifierProvider<BluetoothScan>(create: (_) => BluetoothScan()),
        ChangeNotifierProvider<StudentProvider>(
            create: (_) => StudentProvider()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.deepPurple,
          ),
          home: const LoginScreen()),
    );
  }
}
