import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ghrccst_attendance_app/navigation/navigators.dart';
import 'package:ghrccst_attendance_app/providers/student_provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../providers/lectures_provider.dart';

Future<dynamic> scanQR(
    BuildContext context, String message, dw, StudentProvider student) async {
  final timeTableProvider =
      Provider.of<LecturesProvider>(context, listen: false);
  bool serviceEnabled = false;

  checkServiceEnabled() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
  }

  return await Geolocator.isLocationServiceEnabled()
      ? showDialog(
          context: context,
          builder: ((context) => Dialog(
                child: SizedBox(
                    height: dw,
                    width: dw,
                    child: MobileScanner(
                        allowDuplicates: false,
                        onDetect: (barcode, args) async {
                          if (barcode.rawValue == null) {
                            debugPrint('Failed to scan Barcode');
                          } else {
                            final String code = barcode.rawValue!;
                            debugPrint('Barcode found! $code');
                            try {
                              await timeTableProvider.markPresentDay(code);
                            } catch (e) {
                              print(e);
                            }
                            pop(context);
                          }
                        })),
              )))
      : showDialog(
          context: context,
          builder: ((context) => Dialog(
                  child: SizedBox(
                height: dw * 0.2,
                width: dw * 0.5,
                child: const Center(
                    child: const Text('Please turn on location service ')),
              ))));
}
