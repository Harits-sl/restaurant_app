import 'dart:async';

import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = '/splash-page';

  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushNamedAndRemoveUntil(
        context,
        HomePage.routeName,
        (route) => false,
      ),
    );

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 200,
        ),
      ),
    );
  }
}
