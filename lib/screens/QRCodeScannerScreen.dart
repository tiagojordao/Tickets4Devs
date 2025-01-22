import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCodeScannerScreen extends StatefulWidget {

  const QRCodeScannerScreen({super.key});

  @override
  _QRCodeScannerScreenState createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Validar Ingresso',
            style: TextStyle(fontWeight: FontWeight.w500),  
          ),
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
        ),
        onDetect: (capture) {
          final String? code = capture.barcodes.first.rawValue;
          if(code != null) {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text(
                    'Ingresso validado com sucesso',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: Colors.green,
                );
              }
            );
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text(
                    'Ingresso inválido',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: Colors.red,
                );
              }
            );
          }
        }
      ),
    );
  }
}