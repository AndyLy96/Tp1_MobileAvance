import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tp1_mobile/Pages/ecran_creation.dart';
import 'package:tp1_mobile/Pages/tiroir_nav.dart';

import 'package:intl/intl.dart';

class Task {
  final String taskName;
  final int progress;
  DateTime date;
  final int dateProgress;

  Task({required this.taskName, required this.progress, required this.date , required this.dateProgress});
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
   }

   void createTasks()
   {
     for(int i = 0; i<10; i++)
       {
         tasks.add(
           Task(
               taskName: "Task #$i" ,
               progress: Random().nextInt(100),
               date: DateTime.now(),
               dateProgress: Random().nextInt(100)
           )
         );
       }
   }

   // Widget complexList(int index){
   //   return Column(
   //     crossAxisAlignment: CrossAxisAlignment.stretch,
   //     children: <Widget>[
   //       Row(
   //         children: <Widget>[
   //           Expanded(
   //             child: Padding(
   //               padding: const EdgeInsets.all(8.0),
   //               child: Column(
   //                 crossAxisAlignment: CrossAxisAlignment.start,
   //                 children: <Widget>[
   //                   Text(tasks[index].taskName),
   //                   Text(tasks[index].date),
   //                 ],
   //               ),
   //             ),
   //           ),
   //           Column(
   //             crossAxisAlignment: CrossAxisAlignment.end,
   //             children: <Widget>[
   //               Text(tasks[index].progress.toString()),
   //               Text(tasks[index].dateProgress.toString()),
   //             ],
   //           ),
   //         ],
   //       ),
   //     ],
   //   );
   // }


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
