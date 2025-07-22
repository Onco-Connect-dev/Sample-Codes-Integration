import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// --- This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aurae Health Flutter Integration',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffdc7d57)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      ///--- Passing the url as a positional paramater      
      body: webViewWidget('https://www.auraehealth.com/'),
    );
  }



  ///--- WebView as a widget 

  Widget webViewWidget(String url){
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: WebUri(url),
      ),
      initialSettings: InAppWebViewSettings(
        mediaPlaybackRequiresUserGesture: false,
        allowsInlineMediaPlayback: true,
        iframeAllow: 'camera *', //<------ Requesting all the permissions that neeeded related to camera
      ),
      onPermissionRequest: (controller, request) async {
        final resources = <PermissionResourceType>[];
        if (request.resources.contains(PermissionResourceType.CAMERA)) {
          final cameraStatus = await Permission.camera.request(); //<---------- Requesting camera permission using permission handler package
          if (!cameraStatus.isDenied) {
            resources.add(PermissionResourceType.CAMERA);
          }
        }
        if (request.resources
            .contains(PermissionResourceType.MICROPHONE)) {
          final microphoneStatus = await Permission.microphone.request(); //<---------- Requesting microphone permission using permission handler package
          if (!microphoneStatus.isDenied) {
            resources.add(PermissionResourceType.MICROPHONE);
          }
        }
        ///--- only for iOS and macOS
        if (request.resources
            .contains(PermissionResourceType.CAMERA_AND_MICROPHONE)) {
          final cameraStatus = await Permission.camera.request(); //<---------- Requesting permissions using permission handler package
          final microphoneStatus = await Permission.microphone.request();
          if (!cameraStatus.isDenied && !microphoneStatus.isDenied) {
            resources.add(PermissionResourceType.CAMERA_AND_MICROPHONE);
          }
        }

        return PermissionResponse(
            resources: resources,
            action: resources.isEmpty
                ? PermissionResponseAction.DENY
                : PermissionResponseAction.GRANT);
      },
    );
  }
}