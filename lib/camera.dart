import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  runApp(const CS());
}

class CS extends StatelessWidget {
  const CS({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Camera(),
    );
  }
}

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  final GlobalKey qrKey = GlobalKey();
  String barcode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF146C94),
        title: Text("Scan QR kode promo"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: (controller) {
                controller.scannedDataStream.listen((value) {
                  setState(() {
                    barcode = value.toString();
                  });
                });
              },
            ),
          ),
          Expanded(
            child: Center(
              child: Text('Result: $barcode'),
            ),
          ),
        ],
      ),
    );
  }
}
