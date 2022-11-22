import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghrccst_attendance_app/navigation/arguments.dart';

class OtpScreen extends StatelessWidget {
  OtpScreenArguments args;
  FirebaseAuth auth = FirebaseAuth.instance;

  codeSent() async {
    // Update the UI - wait for the user to enter the SMS code
    String smsCode = '111111';

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: args.verificationId, smsCode: smsCode);
    print(credential);
    // Sign the user in (or link) with the credential
    await auth.signInWithCredential(credential);
  }

  OtpScreen({super.key, required this.args});
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(54.0),
        child: Column(
          children: [
            TextField(
              controller: otpController,
              decoration: const InputDecoration(hintText: 'OTP'),
            ),
            ElevatedButton(
                onPressed: () => codeSent(),
                child: Column(
                  children: [
                    Text(args.verificationId.toString()),
                    Text(args.resendToken.toString())
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
