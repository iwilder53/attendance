// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ghrccst_attendance_app/navigation/navigators.dart';
import 'package:ghrccst_attendance_app/navigation/routes.dart';
import 'package:ghrccst_attendance_app/providers/lectures_provider.dart';
import 'package:ghrccst_attendance_app/providers/student_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  late TextEditingController phoneController = TextEditingController();

  verificationCompleted(PhoneAuthCredential credential) async {
    print('verification complete');
  }


  @override
  Widget build(BuildContext context) {
    codeSent(String verificationId, int? resendToken) async {
      //push(context, NamedRoute.homeScreen);

      // Update the UI - wait for the user to enter the SMS code
      String smsCode = '111111';

      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      // Sign the user in (or link) with the credential
      final user = await auth.signInWithCredential(credential);
      if (user.user != null) {
        print(user.user?.phoneNumber);

        String? number = user.user?.phoneNumber.toString();
        if (number != null) {
          number = number.replaceAll('+91', '');
          print(number);
          bool loginState =
              await Provider.of<StudentProvider>(context, listen: false)
                  .login(int.parse(number));
          await Provider.of<LecturesProvider>(context, listen: false)
              .fetchAndSetLectures(
                  Provider.of<StudentProvider>(context, listen: false));
          if (loginState == true) {
            pushReplacement(context, NamedRoute.homeScreen);
          }
        }
      }
    }

    sendCode(String phoneNumber) async {
      try {
        await auth.verifyPhoneNumber(
            phoneNumber: '+91$phoneNumber',
            verificationCompleted: (PhoneAuthCredential credential) =>
                verificationCompleted(credential),
            verificationFailed: (error) async {
              if (kDebugMode) {
                print(error);
              }
            },
            codeAutoRetrievalTimeout: (error) async {
              if (kDebugMode) {
                print(error);
              }
            },
            codeSent: (String verificationId, int? resendToken) =>
                codeSent(verificationId, resendToken));
      } on Exception catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  hintStyle: TextStyle(fontSize: 14)),
              controller: phoneController,
            ),
            ElevatedButton(
                onPressed: () async {
                  final login = await sendCode(phoneController.text.trim());
                },
                child: const Text('Log In')),
            TextButton(
                onPressed: () => push(context, NamedRoute.registerScreen),
                child: const Text('New Student? register here')),
          ],
        ),
      ),
    );
  }
}
