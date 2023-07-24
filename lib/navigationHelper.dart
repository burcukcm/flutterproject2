import 'package:flutter/material.dart';
import 'package:flutterproject/View/HomePage.dart';
import 'package:flutterproject/View/SecondPage.dart';
import 'package:flutterproject/View/ThirdPage.dart';

class NavigationHelper {
  static void navigateToHomePage(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  static void navigateToSecondPage(BuildContext context, data) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()));
  }

  static void navigateToThirdPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdPage()));
  }
}
