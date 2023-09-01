import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp1_mobile/DIO/lib_http.dart';
import 'package:tp1_mobile/Pages/ecran_creation.dart';
import 'package:tp1_mobile/Pages/tiroir_nav.dart';


import 'package:intl/intl.dart';

class Task {
  final int id;
  final String taskName;
  final int progress;
  DateTime date;
  final double dateProgress;

  Task({required this.id ,required this.taskName, required this.progress, required this.date , required this.dateProgress});


}

class EcranAccueil extends StatefulWidget {
  final String le_parametre;
  const EcranAccueil({Key? key, required this.le_parametre}) : super(key: key);


  @override
  _ecranAccueilState createState() => _ecranAccueilState();
}

class _ecranAccueilState extends State<EcranAccueil> {
  var text;

   List<Task> tasks = [];

   @override
   void initState()
   {
     super.initState();
     createTasks();
     getJson();
   }

   Future<List<Task>> getJson()
   async {
     final response = await SingletonDio.getDio().get('http://10.0.2.2:8080/api/home');
     var vraierep = response.data as List;

     print(vraierep);

     List<Task> items = [];

     for(int i = 0; i < vraierep.length; i++)
     {

       Task task = Task(
           id: vraierep[i]["id"] ,
           taskName: vraierep[i]["name"],
           progress: vraierep[i]["percentageDone"],
           date: DateTime.parse(vraierep[i]["deadline"]) ,
           dateProgress: vraierep[i]["percentageTimeSpent"]);

       items.add(task);

     }

     print(items.toString());
     setState(() {

     });
     return tasks = items;

   }



   void  createTasks() async
   {

     try{
       final response = await SingletonDio.getDio().get('http://10.0.2.2:8080/api/home');
       print("sisijsis"  + response.toString());

       // tasks = (jsonDecode(response.toString()) as List).map((e) => Task)

       // tasks = getJson();

        setState(() {

        });


     }on DioError catch (e){
       final snackBar = SnackBar(
         content: Text(e.response?.data),
       );

       ScaffoldMessenger.of(context).showSnackBar(snackBar);

     }



   }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }
  final TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: LeTiroir(nom_parametre: widget.le_parametre,),
        appBar: AppBar(title: const Text('Accueil'), automaticallyImplyLeading: true,
        actions: [ const Align(
            alignment: Alignment.center,
            child: Text('Crée une tâche', style: TextStyle(fontSize: 20),),
          ),
          IconButton(
            padding: const EdgeInsets.all(0.0),
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
          body: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
             return ListTile(
               onTap:() {
                 Navigator.push(context,
                   MaterialPageRoute(
                     builder: (context) => const EcranCreation(),
                   ),
                 );
               } ,
               subtitle: Row(
                   children: <Widget>[
                     Expanded(
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: <Widget>[
                             Text(tasks[index].taskName),
                             Text(DateFormat("yyyy:MM:dd").format(tasks[index].date)),
                           ],
                         ),
                       ),
                     ),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: <Widget>[
                         Text("Prgrès de la tâche: ${tasks[index].progress}%"),
                         Text("Prgrès de la date limite: ${tasks[index].dateProgress}%"),
                       ],),
                   ],
                 ),
             );
             },
          ),
    );
  }
}
