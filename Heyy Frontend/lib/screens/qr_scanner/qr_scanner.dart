import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:social/theme.dart';

import '../../common/bordered_button.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  static Route route() => MaterialPageRoute(
        builder: (context) => QrScanner(),
      );

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            overlay: QrScannerOverlayShape(
              borderColor: AppColors.secondary,
              borderWidth: 13,
              borderRadius: 20,
            ),
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          // Positioned(
          //   bottom: 50,
          //   left: 120,
          //   width: 100,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       CustomBorderedButton(
          //         radius: 26,
          //         icon: Icons.camera_rear,
          //         onPressed: () {},
          //       ),
          //       CustomBorderedButton(
          //         radius: 26,
          //         icon: Icons.flash_on,
          //         onPressed: () {},
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

// (result != null)
//                   ? Text(
//                       'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
//                   : Text('Scan a code')
