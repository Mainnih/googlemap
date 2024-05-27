import 'package:chill_chat_v2/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'other_login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => OtherMethodLogin(),
            ),
            (route) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/icon_app.png',
              width: 200, // Điều chỉnh kích thước logo theo nhu cầu
              height: 200, // Điều chỉnh kích thước logo theo nhu cầu
            ),
          ),
        ],
      ),
    );
  }
}
