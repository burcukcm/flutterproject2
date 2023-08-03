import 'package:flutter/material.dart';
import 'package:flutterproject/Navigation/navigation_helper.dart';
import 'package:flutterproject/View/second_view.dart';
import 'package:flutterproject/View/third_view.dart';

class HomeViewModel with ChangeNotifier {
  void navigateToSecondView(BuildContext context) {
    NavigationHelper.navigateToPage(context, const SecondView());
  }
  void navigateToThirdView(BuildContext context) {
    NavigationHelper.navigateToPage(context, ThirdView());
  }
}
