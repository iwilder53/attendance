import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';


class BluetoothScan extends ChangeNotifier {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  late String currentLectureId ;
// Start scanning
  startScan() => flutterBlue.startScan(timeout: const Duration(seconds: 5));
  List<ScanResult> scannedDevices = [];
  late ScanResult attendanceDevice;
// Listen to scan results
  getResult() {
    startScan();
    flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
        if (r.device.name == 'Wilder’s iPad(2)') {
          attendanceDevice = r;
          currentLectureId = r.advertisementData.localName;
          stopScan();
          break;
        }
        scannedDevices.add(r); // just for debugging

      }
    });
    //TODO: final currentLecture = 
    stopScan();
    return scannedDevices[0];
  }

// Stop scanning
  stopScan() => flutterBlue.stopScan();
}
