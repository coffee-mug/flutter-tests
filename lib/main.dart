// Step 1: import necessary packages
// import 'package:firebase_core/firebase_core.dart';
// import 'package:webview_futter/webview_flutter.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'dart:async'; // Needed to enable futures and await

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

// Step 2 -
// Turn main function into an async functioon,
// and ensure you call "WidgetsFlutterBinding.ensureInitialized();"
// before initializing your firebase app (it will otherwise crash)
// Your main function should include the following body below (François: copier coller la fonction main)
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  // Step 3: Initialize the FirebaseAnalytics widget.
  // The documentation recommends final
  final FirebaseAnalytics analytics = FirebaseAnalytics();

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
            // Step 4: here, for the sake of simplicity, we directly instantiate
            // our WebView widget as the body argument. We use the external interface
            // http://10.0.2.2:8000 to communicate with our local webserver listening
            // on localhost:8000 (as the app runs on another device).
            body: WebView(
              // rnning on anoter device, can 't put localhost, must use the ext net interface
              initialUrl: "http://10.0.2.2:8000",
              javascriptMode: JavascriptMode.unrestricted,

              // Step 5: we use the javascriptChannels parameter, with a javascriptChannel array,
              //  which allows the webview
              // to create a communication channel between the javscript context of the webview
              // and the the flutter app. This channel is established by setting a global function
              // in the JS context of the webview, that, when called, will send a WebView.JavascriptMessage
              // to the flutter app, triggering the "onMessageReceived" handler. The WebView.JavasscriptMessage
              // is the argument passed to the function in the JS context. Here, in our exemple, we called the function
              // "Print" but feel free to rename it if you wish.
              javascriptChannels: <JavascriptChannel>[
                JavascriptChannel(
                    name: 'Print',
                    onMessageReceived: (JavascriptMessage msg) {
                      // Step 6: Here we are in the listener getting called everytime a message is sent from
                      // the webview context. Here, the message would be the screen name currently displayed
                      // on the webview. JavascriptMessage is a struct defined by the webView library, to access
                      // the value of the message, check the "message" property - Here, for instance, to check the value
                      // sent we'll check msg.message.
                      // INTERNAL 555: useful doc: https://medium.com/@mksl/flutter-talking-to-a-webview-747da85a0815
                      // CAUTION: in the article above, they mention it's a "developer preview feature" - don't get stressed
                      // the article is from 2019... JavascriptChannel is now a production feature, no worries.
                      analytics.setCurrentScreen(screenName: msg.message);
                      print(msg.message);
                    }),
              ].toSet(),
            )));
  }
}
