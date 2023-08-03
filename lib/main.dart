
import 'package:flutter/material.dart';
import 'View/home_view.dart';
import 'package:flutterproject/constants/app_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.projectLabel,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.thirdColor),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}
