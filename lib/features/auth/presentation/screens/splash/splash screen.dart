


import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../../shared/app image.dart';
import '../onbording/onbording layou.dart';

class AppSplashScreen extends StatefulWidget {


  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }
// function to navigate after 3 second
  void navigate() {
    Timer(const Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return OnBordingLayout();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset(AppImage.splash)),
        ],
      ),
    );
  }
}