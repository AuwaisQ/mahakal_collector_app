import 'package:flutter/material.dart';

import 'features/login/loginscreen.dart';
import 'features/otpverify/otpverify.dart';
import 'features/splash/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collector App',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
