import 'package:flutter/material.dart';
import 'package:go_moon/pages/home_page.dart';

void main() {
  runApp( const App());
}

class App extends StatelessWidget{
const App({Key? key}) : super(key: key);

@override
  Widget build(BuildContext context) {
     return MaterialApp(
                        title: 'VinWorld',
                        theme: ThemeData(scaffoldBackgroundColor: Color.fromARGB(31,31, 31, 1), ),
                        home:HomePage(),);
  }
}

