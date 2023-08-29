import 'package:flutter/material.dart';
import 'package:navigation_flutter/ecran_a.dart';
import 'package:navigation_flutter/home.dart';


void main() {runApp(MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: EcranHome(),
      routes: routes(),
    );
  }

  Map<String, WidgetBuilder> routes() {
    return {
      '/ecrana': (context) => EcranA(le_parametre: '',),
      '/home': (context) => EcranHome(),
    };
  }

}
