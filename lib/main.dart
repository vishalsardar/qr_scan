import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import "package:flutter/services.dart";

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = "Hey there!";
  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera Permission was denied";
        });
      }else{
        setState(() {
          result = "Unknown Error $ex"; 
        });
      }
    }on FormatException{
      setState(() {
        result = "You've pressed the back button before scannning" ;
      });
    }catch(ex){
        result = "Unknown Error $ex"; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan_C0de By Vish's")),
      body: Center(
          child: Text(result,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.camera),
          onPressed: _scanQR,
          label: Text(
            "Scan",
            style: TextStyle(fontSize: 18),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}