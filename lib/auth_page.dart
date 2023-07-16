import 'package:flutter/material.dart';
import 'package:pettakecarebeta23/screen/login.dart';
import 'package:pettakecarebeta23/screen/register.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(showRegisterScreen: toggleScreen);
    } else {
      return RegisterPage(showLoginScreen: toggleScreen, showLoginPage: () {  },);
    }
  }
}