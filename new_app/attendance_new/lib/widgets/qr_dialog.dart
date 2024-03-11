import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../providers/lectures_provider.dart';

Future<dynamic> qrDialog(BuildContext context, String message, dw) {
  return showDialog(
      context: context,
      builder: ((context) => Dialog(
            child: SizedBox(
              height: dw,
              width: dw,
              child: QrImageView(
                  data: message,
                  version: QrVersions.auto,
                  errorStateBuilder: (cxt, err) {
                    return Container(
                      child: Center(
                        child: Text(
                          'Uh oh! Something went wrong...',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }),
            ),
          )));
}