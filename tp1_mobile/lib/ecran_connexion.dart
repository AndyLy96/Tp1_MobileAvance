import 'package:flutter/material.dart';

class ConnexionPage extends StatefulWidget {

  @override
  _ConnexionPage createState() => _ConnexionPage();

}

class _ConnexionPage extends State<ConnexionPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Perform login logic here, e.g., check credentials
      // For demonstration purposes, just print the values
      print('Username: ${username.text}');
      print('Password: ${password.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connexion')),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: username,
                decoration: InputDecoration(labelText: 'Nom d\'utilisateur'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mettre votre nom utilisateur';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: password,
                decoration: InputDecoration(labelText: 'Mot de Passe'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mettre votre mot de passe';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Connexion'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}