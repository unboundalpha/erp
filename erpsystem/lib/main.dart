import 'package:erpsystem/AttendanceDetailScreen.dart';
import 'package:erpsystem/AttendanceScreen.dart';
import 'package:erpsystem/AuthenticationScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyCjzGeYELW8Mli6YvSt-KwzaO3vtRak7Zw",
    appId: "1:971430504064:android:ea70adcedaad808b0be865",
    messagingSenderId: "",
    projectId: "erp-system-eb009",
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Construction Worker Attendance Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthenticationScreen(),
      routes: {
        '/attendance': (context) => AttendanceScreen(),
        '/attendance-details': (context) => AttendanceDetailScreen(),
      },
    );
  }
}
