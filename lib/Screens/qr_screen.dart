import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constant/app_colors.dart';
import '../constant/button_widget.dart';
import '../constant/custom_appbar.dart';
import '../constant/language_constants.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  String _employeeName = "";

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          _employeeName = user.displayName ?? "";
        });
      }
    });
  }

  bool _qrCodeActive = true;
  Color _buttonColor = Colors.blue;

  void _toggleQRCode() {
    setState(() {
      _qrCodeActive = !_qrCodeActive;
      _buttonColor = _qrCodeActive ? Colors.blue : Colors.grey;
    });
  }


  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: translation(context).qr_code,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(border: Border.all(width: 2)),
                  child: _qrCodeActive
                      ? QrImage(
                          data: _employeeName,
                          version: QrVersions.auto,
                          size: 300.0,

                        )
                      : const Text(
                          "QR Code is deactivated.",
                          style: TextStyle(fontSize: 20.0),
                        ),
                ),
                // Padding(
                //     padding:
                //         const EdgeInsets.only(top: 10, left: 40, right: 40),
                //     child: ButtonWidget(
                //             text: _qrCodeActive ? 'Deactivate QR' : 'Activate QR',
                //             onClicked: () {
                //               _toggleQRCode;
                //             },
                //             color: AppColors.primary)
                // ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0,right: 20),
        child: Container(
          height: 80.0,
          width: 80.0,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: _toggleQRCode,
              backgroundColor: _buttonColor,
              tooltip: _qrCodeActive ? 'Deactivate QR' : 'Activate QR',
              child: Icon(_qrCodeActive ? Icons.power_settings_new : Icons.power_settings_new_outlined),
            ),
          ),
        ),
      ),

    );
  }
}
