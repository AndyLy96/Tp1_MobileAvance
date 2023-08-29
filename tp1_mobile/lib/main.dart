import 'package:flutter/material.dart';
import 'package:tp1_mobile/ecran_accueil.dart';
import 'package:tp1_mobile/ecran_connexion.dart';


void main() {runApp( MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: EcranAccueil(),
      routes: routes(),
    );
  }

  Map<String, WidgetBuilder> routes() {
    return {
      '/home': (context) => ConnexionPage(),
    };
  }

}
