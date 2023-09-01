import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp1_mobile/DIO/transfer.dart';
import 'package:tp1_mobile/Pages/ecran_accueil.dart';
import 'package:tp1_mobile/Pages/tiroir_nav.dart';

class EcranCreation extends StatefulWidget {
  const EcranCreation({super.key});

  @override
  _ecranCreationState createState() => _ecranCreationState();
}

class _ecranCreationState extends State<EcranCreation> {
  var text;

  TextEditingController taskName = TextEditingController();
  // TextEditingController password = TextEditingController();

  String _name = "";
  DateTime _selectedDate = DateTime.now();


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  final dio = Dio();


  void _addTask() async {
    AddTaskRequest addTask = AddTaskRequest(taskName.text, _selectedDate);


    try{
      final response = await dio.post('http://10.0.2.2:8080/api/add', data: addTask.toJson());
      //SigninResponse signinResponse = SigninResponse(response.data);
      Navigator.push(context ,
        MaterialPageRoute(
          builder: (context) => const EcranAccueil(le_parametre: ''),
        ),
      );
      print(response);

    }on DioError catch (e){
      final snackBar = SnackBar(
        content: Text(e.response?.data),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }

  }


  final TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Création'), automaticallyImplyLeading: true,),

    drawer: const LeTiroir(nom_parametre: '',),
      body: Padding(

        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 200,),
            const Text(
              'Nom de la tâche:',
              style: TextStyle(fontSize: 18),
            ),
            TextFormField(
              controller: taskName ,
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Choisir la date:',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 10),
                Text(
                  '${_selectedDate.toLocal()}'.split(' ')[0],
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () => _selectDate(context),
                  icon: const Icon(Icons.calendar_today),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTask,
              child: const Text('Page Acceuil'),
            ),
          ],
        ),
      ),
    );
  }
}
