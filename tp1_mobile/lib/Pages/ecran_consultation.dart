import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp1_mobile/DIO/lib_http.dart';
import 'package:tp1_mobile/DIO/transfer.dart';
import 'package:tp1_mobile/Pages/ecran_accueil.dart';
import 'package:tp1_mobile/Pages/ecran_inscription.dart';
import 'package:tp1_mobile/Pages/tiroir_nav.dart';


class DetailPage extends StatefulWidget {
  final int leID;
  const DetailPage({Key? key, required this.leID}) : super(key: key);


  @override
  _DetailPage createState() => _DetailPage();

}

class _DetailPage extends State<DetailPage> {
  TextEditingController progress = TextEditingController();


  @override
  void initState()
  {
    super.initState();
    detail();
  }

 Task task = new Task(
     id: 0,
     taskName: '',
     date: DateTime.now(),
     dateProgress: 0,
     progress: 0
 );


  Future<Task> detail() async {

      final response = await SingletonDio.getDio()
          .get('http://10.0.2.2:8080/api/detail/' + widget.leID.toString());
      //SigninResponse signinResponse = SigninResponse(response.data);
      print(response);

      var vraierep = response.data;

      print(vraierep);

      Task tempTask = Task(
          id: widget.leID ,
          taskName: vraierep["name"],
          progress: vraierep["percentageDone"],

          date: DateTime.parse(vraierep["deadline"]) ,
          dateProgress: vraierep["percentageTimeSpent"]
      );
      setState(() {});

      return task = tempTask;


  }

  void taskUpdate() async {



    try{
      final response = await SingletonDio.getDio().get('http://10.0.2.2:8080/api/progress/' +task.id.toString()+ '/' + progress.text,);
      print(response);
      Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => EcranAccueil(le_parametre: ''),
        ),
      );
    }on DioError catch (e){
      final snackBar = SnackBar(
        content: Text(e.response?.data),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }

  }

  @override
  Widget build(BuildContext context) {
    final df = new DateFormat('yyyy-MM-dd');
    return Scaffold(
        drawer: LeTiroir(nom_parametre: 'to be fixed'),
        appBar: AppBar(title: const Text('Détails'), automaticallyImplyLeading: true,),
        body: Padding(
            padding: const EdgeInsets.all(16.0),

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Détails (2 secs pls!) ',
                  style: TextStyle(fontSize: 40),
                ),
                const SizedBox(height: 35),
                Text(
                    'Nom de la tâche: ' + task.taskName,
                    style: TextStyle(fontSize: 20)
                ),
                const SizedBox(height: 20),
                Text(
                    'Date d\'échéance: ' +  df.format(task.date),
                    style: TextStyle(fontSize: 20)
                ),
                const SizedBox(height: 20),
                Text(
                    'Pourcentage de temps écoulé: ' + task.dateProgress.toString() ,
                    style: TextStyle(fontSize: 20)
                ),
                const SizedBox(height: 20),
                Text(
                    'Pourcentage d\'avancement: ',
                    style: TextStyle(fontSize: 20)
                ),
                TextFormField(
                  controller: progress,
                  decoration: InputDecoration(
                    hintText: task.progress.toString()
                  ),
                  keyboardType: TextInputType.number,
                  validator: (progress) {
                    if(int.parse(progress.toString()) < 0  || int.parse(progress.toString()) > 100)
                    {
                      return 'Valeur entre 0 et 100';
                    }
                    return null;
                  }

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    MaterialButton(
                      onPressed: taskUpdate,

                      child: const Text('Acceuil'),

                    ),

                  ],
                )


              ],
            )
        )
    );
  }
}