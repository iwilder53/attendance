import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothScan extends ChangeNotifier {
  FlutterBlue flutterBlue = FlutterBlue.instance;

// Start scanning
  startScan() => flutterBlue.startScan(timeout: const Duration(seconds: 2));
  List<ScanResult> scannedDevices = [];
  late ScanResult attendanceDevice;
// Listen to scan results
  getResult() {
    startScan();

    flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
        if (r.device.name.toString().split(' ')[0] == 'iPad' && r.rssi > -50) {
          attendanceDevice = r;
        }
        scannedDevices.add(r); // just for debugging

      }
    });

    stopScan();
    return attendanceDevice;
  }

// Stop scanning
  stopScan() => flutterBlue.stopScan();
}
