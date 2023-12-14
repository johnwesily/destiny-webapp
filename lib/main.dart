import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StoragePermissionAndWebViewExample(),
    );
  }
}

class StoragePermissionAndWebViewExample extends StatefulWidget {
  const StoragePermissionAndWebViewExample({Key? key}) : super(key: key);

  @override
  _StoragePermissionAndWebViewExampleState createState() =>
      _StoragePermissionAndWebViewExampleState();
}

class _StoragePermissionAndWebViewExampleState
    extends State<StoragePermissionAndWebViewExample> {
  @override
  void initState() {
    super.initState();
    checkAndRequestStoragePermission();
  }

  Future<void> checkAndRequestStoragePermission() async {
    await requestStoragePermission();
    await requestLocationPermission();
    // await requestSMSPermission();

    if (await PermissionGranted()) {
      navigateToWebView();
    } else {
      // Handle the case where storage permission is not granted
      print("permission not granted");
    }
  }

  Future<bool> PermissionGranted() async {
   var  Storage_status = await Permission.storage.status;
    var location_status = await Permission.location.status;
    // var sms_status =await Permission.sms.status ;
    return Storage_status.isGranted && location_status.isGranted   ;
  }



  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.request();
    print('Storage permission request status: $status');

    if (status.isGranted) {
      print("Storage permission granted");
    } else {
      // Handle denied case if needed
      print("Storage permission denied");
    }
  }

  Future<void> requestLocationPermission() async {
    var locationStatus = await Permission.location.request();
    print('Location permission status: $locationStatus');
    if (locationStatus.isDenied) {
      // Handle denied case if needed
      print("permission deined location ");
    }
  }

  Future<void> requestSMSPermission() async {
      var smsStatus = await Permission.sms.request();
      print('SMS permission status: $smsStatus');
      if (smsStatus.isDenied) {
        // Handle denied case if needed
        print("permission deined sms");
      }
    }


  void navigateToWebView() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const WebViewExample(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class WebViewExample extends StatelessWidget {
  const WebViewExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 3.0,
      ),
      body: const WebView(
        initialUrl: 'https://dev.destini.ai/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
