import 'package:flutter/material.dart';
import 'package:tp1_mobile/Pages/ecran_creation.dart';
import 'package:tp1_mobile/Pages/ecran_inscription.dart';
import 'package:tp1_mobile/Pages/tiroir_nav.dart';

class EcranAccueil extends StatefulWidget {
  final String le_parametre;
  const EcranAccueil({Key? key, required this.le_parametre}) : super(key: key);

  @override
  _ecranAccueilState createState() => _ecranAccueilState();
}

class _ecranAccueilState extends State<EcranAccueil> {
  var text;

  final TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        drawer: LeTiroir(),
        //TODO decommenter la ligne suivante
        appBar: AppBar(title: const Text('Accueil'), automaticallyImplyLeading: true,
        actions: [
          Align(
            alignment: Alignment.center,
            child: Text('Création', style: TextStyle(fontSize: 20),),
          ),
          IconButton(
            padding: EdgeInsets.all(0.0),
            icon: const Icon(Icons.arrow_circle_right, size: 40,),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => const EcranCreation(),
                ),
              );
            },
          ),
        ],),
        body: Text(widget.le_parametre)
    );
  }
}
