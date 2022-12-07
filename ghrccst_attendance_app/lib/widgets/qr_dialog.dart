import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

Future<dynamic> qrDialog(BuildContext context, String message, dw) {
  return showDialog(
      context: context,
      builder: ((context) => Dialog(
            child: SizedBox(
              height: dw,
              width: dw,
              child: QrImage(
                data: message,
                version: QrVersions.auto,
              ),
            ),
          )));
}