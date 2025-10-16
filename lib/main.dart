import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent)); //AppBar 쓰면 SystemChrome 설정 무시하므로 반영안됨
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      home: Home(),
    );
  }
}