import 'package:smsauth/screens/homescreen.dart';
import 'package:smsauth/screens/smsscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

Future<bool> getStatus() async {
  final bool isActive;
  final prefs = await SharedPreferences.getInstance();
  //isActive = await prefs.remove('isActive');
  isActive = prefs.getBool('isActivate') ?? false;

  return isActive;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'اپلیکیشن احراز هویت با پیامک',
      home: FutureBuilder(
        future: getStatus(),
        builder: (contex, snapshot) {
          if (snapshot.data == true) {
            return const HomePage();
          } else {
            return const SMSScreen();
          }
        },
      ),
    );
  }
}
