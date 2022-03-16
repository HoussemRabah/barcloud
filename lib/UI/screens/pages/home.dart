import 'package:barcloud/UI/screens/views/scannerView.dart';
import 'package:barcloud/logic/functions/navigation.dart';
import 'package:barcloud/repository/qr_repo.dart';
import 'package:barcloud/repository/scanner_repo.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

ScannerRepository scannerAPI = ScannerRepository();
QrRepository qrAPI = QrRepository();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
              child: Icon(Icons.qr_code),
              onPressed: () {
                openScreen(context, ScannerView());
              }),
          SizedBox(
            width: 8.0,
          ),
          FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          qrAPI.getQRImage("hello world this is my PFE", 200.0)
        ],
      ),
    );
  }
}
