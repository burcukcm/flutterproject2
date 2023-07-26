import 'package:flutter/material.dart';
import 'package:flutterproject/View/main.dart';
import 'package:flutterproject/View/SecondPage.dart';
import 'package:flutterproject/View/ThirdPage.dart';

class NavigationHelper {
  static void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
