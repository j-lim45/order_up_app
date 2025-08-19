import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:order_up_app/auth_service.dart';
import 'package:order_up_app/loading_screen.dart';
import 'auth_service.dart';
import 'home_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();    // control the credential textboxes
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService, // Pay attention and listen if this authService changes or smthn
      builder: (context, authService, child) {
        return StreamBuilder(
          stream: authService.authStateChanges, 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) { // are u waiting?
              return LoadingScreen();
            } else if (snapshot.hasData) { // are u logged in?
              return AppHomePage();
            } else {
              return Scaffold( // !!! needs its own class for the actual Login page !!!
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
                              controller: emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Email Address'
                              ),
                            ),
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Password'
                              ),
                            ),
                            ElevatedButton(
                              onPressed: clickLoginButton, 
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
        );
      }
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void clickLoginButton() async {
    try {
      await authService.value.signIn(email: emailController.text, password: passwordController.text);
    } catch (e) {
      showError(e);
    }
  }

  void showError(Object e) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('An error occurred.'),
          content: Text('$e'),
          actions: <Widget>[TextButton(onPressed: () => Navigator.pop(context, 'OK'), child: const Text('OK'))],
        ),
      );
  }
}
