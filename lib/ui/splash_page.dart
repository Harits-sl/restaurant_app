import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/ui/main_page.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = '/splash-page';

  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => Navigation.intentReplacement(
        MainPage.routeName,
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
