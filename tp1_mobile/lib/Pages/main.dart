

import 'package:flutter/material.dart';
import 'package:tp1_mobile/Pages/ecran_accueil.dart';
import 'package:tp1_mobile/Pages/ecran_connexion.dart';
import 'package:tp1_mobile/Pages/ecran_inscription.dart';
import 'package:dio/dio.dart';



void main() {runApp( const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const ConnexionPage(),
      routes: routes(),
      debugShowCheckedModeBanner: false,
    );
  }

  Map<String, WidgetBuilder> routes() {
    return {
      '/home': (context) => const ConnexionPage(),
      '/acceuil': (context) => EcranAccueil(le_parametre: '' ,),
      '/inscription': (context) => const EcranInscription()
    };
  }

}
