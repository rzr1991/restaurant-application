import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurants/common/styles.dart';

import 'navigation_menu.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashscreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashScreen();
  }

  splashScreen() {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(context, NavigationMenu.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Lottie.network(
                    'https://assets10.lottiefiles.com/packages/lf20_clbsgvch.json',
                    width: 300,
                    height: 300)),
            const SizedBox(height: 24.0),
            const Text(
              "Restaurant Application",
              style: Styles.splashScreenText,
            ),
          ],
        ),
      ),
    );
  }
}
