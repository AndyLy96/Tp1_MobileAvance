import 'package:flutter/material.dart';
import 'package:tp1_mobile/Pages/ecran_accueil.dart';
import 'package:tp1_mobile/Pages/ecran_inscription.dart';
import 'package:tp1_mobile/Pages/tiroir_nav.dart';

class EcranCreation extends StatefulWidget {
  const EcranCreation({super.key});

  @override
  _ecranCreationState createState() => _ecranCreationState();
}

class _ecranCreationState extends State<EcranCreation> {
  var text;


  String _name = "";
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  final TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Création'), automaticallyImplyLeading: true,),

    drawer: LeTiroir(nom_parametre: '',),
      body: Padding(

        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 200,),
            Text(
              'Nom de la tâche:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Choisir la date:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 10),
                Text(
                  '${_selectedDate.toLocal()}'.split(' ')[0],
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () => _selectDate(context),
                  icon: Icon(Icons.calendar_today),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EcranAccueil(le_parametre: "",),
                  ),
                );
              },
              child: Text('Page Acceuil'),
            ),
          ],
        ),
      ),
    );
  }
}
