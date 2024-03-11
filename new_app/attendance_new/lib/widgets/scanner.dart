// ignore_for_file: use_build_context_synchronously

import 'package:attendance_new/navigation/navigators.dart';
import 'package:attendance_new/providers/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
      // ignore: use_build_context_synchronously
      ? showDialog(
          context: context,
          builder: ((context) => Dialog(
                child: SizedBox(
                    height: dw,
                    width: dw,
                    child: MobileScanner(
                        controller: MobileScannerController(
                          detectionSpeed: DetectionSpeed.normal,
                          facing: CameraFacing.front,
                          torchEnabled: true,
                        ),
                        onDetect: (barcode) async {
                          if (barcode.raw == null) {
                            debugPrint('Failed to scan Barcode');
                          } else {
                            final String code = barcode.raw!;
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
                    child: Text('Please turn on location service ')),
              ))));
}
