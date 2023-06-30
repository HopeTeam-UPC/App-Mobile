import 'package:flutter/material.dart';
import 'package:go2climb/screens/home.dart';
import 'package:go2climb/widgets/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
      //home: HomeScreen()
    );
  }
}
