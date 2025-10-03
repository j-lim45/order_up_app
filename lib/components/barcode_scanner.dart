import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({super.key});

  @override
  State<BarcodeScanner> createState() => _BarcodeScanner();
}

class _BarcodeScanner extends State<BarcodeScanner> {

  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    detectionTimeoutMs: 250,
    formats: [BarcodeFormat.ean13, BarcodeFormat.ean8, BarcodeFormat.upcA],
    returnImage: false,
    torchEnabled: false,
    invertImage: false,
    autoZoom: false,
  );
  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: controller,
      onDetect: (result) {
        print(result.barcodes.first.rawValue);
      },
    );
  }
}