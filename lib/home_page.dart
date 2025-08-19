import 'package:flutter/material.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePage();
  
}

  class _AppHomePage extends State<AppHomePage> {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false, // this should work but it doesnt
        home: Scaffold(
          body: Center(child: Text("HELLO, HELLO"),)
        )
      );
    }
  }

