import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPage();

  }

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(child: Image.network('https://www.orderup.com.au/file/2019/03/logo18.png')),
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Text('Log in to OrderUp!'),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email Address'
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password'
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {}, 
                    child: Text('Login')
                  )
                ],
              )
            )
          )
          
        ],
      )
      
    );
  }
}