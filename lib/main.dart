import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:edukit/utill/app_constants.dart';
import 'package:edukit/view/screen/signup/signupscreen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appNAME,
      navigatorKey: navigatorKey,
      locale: const Locale('en'),
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
      ],
      scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          }),
      home: const SignUpScreen(),
    );
  }
}