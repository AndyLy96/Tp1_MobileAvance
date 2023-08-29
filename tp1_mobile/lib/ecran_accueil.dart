import 'package:flutter/material.dart';

class EcranAccueil extends StatefulWidget {
  @override
  _ecranAccueilState createState() => _ecranAccueilState();
}

class _ecranAccueilState extends State<EcranAccueil> {
  var text;

  final TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO decommenter la ligne suivante
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Accueil'),
        ),
        body: Text('Andy')
    );
  }
}
