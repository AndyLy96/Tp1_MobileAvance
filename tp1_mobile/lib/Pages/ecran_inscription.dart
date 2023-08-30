import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp1_mobile/DIO/transfer.dart';
import 'package:tp1_mobile/Pages/ecran_accueil.dart';

class EcranInscription extends StatefulWidget {
  const EcranInscription({super.key});


  @override
  _EcranInscription createState() => _EcranInscription();

}

class _EcranInscription extends State<EcranInscription> {

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();



  final dio = Dio();
  late String psw;

  void _signup() async {


    if(password.text == confirmPassword.text)
    {
        this.psw = password.text;
    }

    SignupRequest signup = SignupRequest(username.text, psw);

    try{
      final response = await dio.post('http://10.0.2.2:8080/api/id/signup', data: signup.toJson());
      //SigninResponse signinResponse = SigninResponse(response.data);
      print(response);
      Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => const EcranAccueil(),
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
    return Scaffold(
      appBar: AppBar(title: const Text('Inscription')),
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
              TextFormField(
                controller: confirmPassword,
                decoration: const InputDecoration(labelText: 'Confirmer mot de Passe'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirmer votre mot de passe';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  MaterialButton(
                    onPressed: _signup,
                    // ()
                    // {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => EcranAccueil(),
                    //     ),
                    //   );
                    // },
                    child: const Text('Connexion'),

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