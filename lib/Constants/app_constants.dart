import 'dart:core';
import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primaryColor = Color(0xFF00ADEF);
  static const Color secondaryColor = Color(0xFFE53935);
  static const Color thirdColor = Color(0xFF181B9D);
  static const Color fifthColor = Color(0xFF03A9F4);
  static const Color sixthColor = Colors.white;
  static const Color seventhColor = Colors.black;
  static const Color eighthColor = Colors.red;
  static const Color ninthColor = Colors.white54;
}

abstract class AppSize {
  static const double sizedBoxHeight1 = 55.0, sizedBoxWidth1 = double.infinity;
  static const double rightPaddingValue = 45.0;
  static const double paddingSize = 35.0;
  static const double sizedBoxHeight = 16.0;
  static const double sizedBoxWidth = 175.0;
  static const double padding1 = 10.0;
  static const double padding2 = 20.0;
  static const double paddingRightBig = 40.0;
  static const double paddingRight = 15.0;
  static const double paddingLeft = 15.0;
  static const double iconSize = 30.0;
}

abstract class AppImages {
  static const String imagePath1 = 'photos/code.jpg';
}

abstract class BorderSize {
  static const double borderRadiusCircular = 150.0;
  static const double borderWidth = 2.0;
}

abstract class Font {
  static const double fontSize = 15.0;
  static const double buttonFont = 20.0;
  static const double textFontSize = 20.2;
  static const double entryFont = 50.0;
}

class AppStrings {
  static const String projectLabel = "MİRSAD ASSISTANT";
  static const String entryText = "\"WELCOME!\"";
  static const String refreshText = "REFRESH";
  static const String newText = "NEW";
  static const String saveText = "SAVE";
  static const String portText = "Port :";
  static const String branchText = "Branch :";
  static const String titleText = "Title :";
  static const String dateText = "Date :";
  static const String errorText = "ERROR!";
  static const String deleteText = "CONFIRM TO DELETE";
  static const String questionText = 'Are you sure you want to delete this item?';
  static const String approveText = "Yes";
  static const String refuseText = "No";
  static const String invalidText =
      "Invalid port number.Please enter positive number!";
  static const String okText = "OK";
  static const String fillText = "Please fill in all fields.";
}
