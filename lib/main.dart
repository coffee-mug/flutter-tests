import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Webview project',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text("HEY WEBVIEWS"),
            ),
            body: WebView(
              // rnning on anoter device, can 't put localhost, must use the ext net interface
              initialUrl: "http://10.0.2.2:8000",
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: <JavascriptChannel>[
                JavascriptChannel(
                    name: 'Print',
                    onMessageReceived: (JavascriptMessage msg) {
                      print(msg.message);
                    }),
              ].toSet(),
            )));
  }
}
