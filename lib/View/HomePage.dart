import 'package:flutterproject/View/SecondPage.dart';
import 'package:flutterproject/View/ThirdPage.dart';
import 'package:flutter/material.dart';
import '../MyDecoratedBox.dart';
import 'package:flutterproject/constants/a.constants.dart';
import 'package:flutterproject/navigationHelper.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mirsad Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:AppColors.thirdColor),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar1(),
      body: MyDecoratedBox(),
    );
  }
}
