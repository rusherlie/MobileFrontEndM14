import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todosapp/mainpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return MainPage();
        },
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitPulsingGrid(
            color: Colors.white,
            size: 150,
          ),
          SizedBox(
            height: 100,
          ),
          Material(
            color: Colors.transparent,
            child: Text(
              'To Do App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold
              ),
            )
          )
        ],
      )
    );
  }
}
