import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initializes binding before running Firebase
  try {
    await Firebase.initializeApp(); // Initializes Firebase
    runApp(
      const MyApp(connected: true),
    ); // Runs app normally if connection is successfully made
  } catch (e) {
    runApp(MyApp(connected: false, error: e.toString()));
  }
}

class MyApp extends StatelessWidget {
  final bool connected;
  final String? error;
  const MyApp({super.key, required this.connected, this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {'/': (context) => LoginPage()}, // Goes to Login page
    );
  }
}
