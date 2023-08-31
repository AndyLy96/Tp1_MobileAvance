import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp1_mobile/Pages/ecran_accueil.dart';
import 'package:tp1_mobile/Pages/ecran_connexion.dart';
import 'package:tp1_mobile/Pages/ecran_creation.dart';


class LeTiroir extends StatefulWidget {
  final String nom_parametre;

  const LeTiroir({Key? key, required this.nom_parametre}) : super(key: key);
  // const EcranAccueil({Key? key, required this.le_parametre}) : super(key: key);


  @override
  State<StatefulWidget> createState() => LeTiroirState();
}

class LeTiroirState extends State<LeTiroir> {

  final dio = Dio();


  void _signOut() async {


    try{
      final response = await dio.post('http://10.0.2.2:8080/api/id/signout');
      Navigator.push(context ,
        MaterialPageRoute(
          builder: (context) => ConnexionPage(),
        ),
        // arguments: {"name" : username.text}
      );

      print(response);


    }on DioError catch (e){
      final snackBar = SnackBar(
        content: Text(e.response?.data),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }

  }



  @override
  Widget build(BuildContext context) {
    var listView = ListView(
      padding: EdgeInsets.zero,

      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Text(widget.nom_parametre, style: TextStyle(fontSize: 20),),
        ),

        Container(height: 200, ),
        ListTile(
          dense: true,
          leading: Icon(Icons.arrow_back_outlined),
          title: Text("Accueil"),
          onTap: () {
            // TODO ferme le tiroir de navigation
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EcranAccueil(le_parametre: '',),
              ),
            );
            // Then close the drawer
          },
        ),
        ListTile(
          dense: true,
          leading: Icon(Icons.add_box),
          title: Text("Ajout de tâche"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EcranCreation(),
              ),
            );
            // Then close the drawer
          },
        ),
        ListTile(
          dense: true,
          leading: Icon(Icons.logout),
          title: Text("Déconnexion"),
          onTap: _signOut
        ),
        // ListTile(
        //   dense: true,
        //   leading: Icon(Icons.ac_unit),
        //   title: Text("Consultation"),
        //   onTap: () {
        //     // TODO ferme le tiroir de navigation
        //     Navigator.of(context).pop();
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => EcranAccueil(),
        //       ),
        //     );
        //     // Then close the drawer
        //   },
        // ),
      ],
    );

    return Drawer(
      child: new Container(
        color: const Color(0xFFFFFFFF),
        child: listView,
      ),
    );
  }
}