import 'package:apptest/pages/login_page.dart';
import 'package:apptest/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegisterPage extends StatefulWidget {
  LoginOrRegisterPage({Key? key}) : super(key: key);

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  // mostrar LoginPage Inicialmente
  bool showLoginPage = true;

  //alterar entre a LoginPage e LoginOrRegisterPage
  void tooglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: tooglePages,
      );
    } else {
      return RegisterPage(
        onTap: tooglePages,
      );
    }
  }
}
