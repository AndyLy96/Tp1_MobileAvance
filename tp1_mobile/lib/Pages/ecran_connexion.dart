import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp1_mobile/DIO/lib_http.dart';
import 'package:tp1_mobile/DIO/transfer.dart';
import 'package:tp1_mobile/Pages/ecran_accueil.dart';
import 'package:tp1_mobile/Pages/ecran_inscription.dart';
// import 'org.kickmyb.transfer.SigninRequest';
// import 'org.kickmyb.transfer.SigninResponse'';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key});


  @override
  _ConnexionPage createState() => _ConnexionPage();

}

class _ConnexionPage extends State<ConnexionPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  final dio = Dio();


  void _login() async {

    SignupRequest signup = SignupRequest(username.text, password.text);

    try{
      final response = await dio.post('http://10.0.2.2:8080/api/id/signin', data: signup.toJson());
      //SigninResponse signinResponse = SigninResponse(response.data);
      Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => const EcranAccueil(),
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




  void getHttp() async {
    final response = await dio.get('https://dart.dev');
    print(response);
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connexion')),
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: username,
                decoration: const InputDecoration(labelText: 'Nom d\'utilisateur'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mettre votre nom utilisateur';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: password,
                decoration: const InputDecoration(labelText: 'Mot de Passe'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mettre votre mot de passe';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  MaterialButton(
                    onPressed: _login,
                    child: const Text('Connexion'),

                  ),
                  MaterialButton(
                    onPressed:
                    ()
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EcranInscription(),
                        ),
                      );
                    },
                    child: const Text('Inscription'),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}