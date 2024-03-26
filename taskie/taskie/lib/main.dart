import 'package:flutter/material.dart';
import 'package:taskie/pages/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter('hive_boxes');
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key})  : super();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VinTask',
      theme: ThemeData(
       
        primarySwatch: Colors.red,
      ),
      home:Homepage(),
    );
  }
}

