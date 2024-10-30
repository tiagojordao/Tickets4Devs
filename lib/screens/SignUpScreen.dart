import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Tickets4Devs - Cadastro",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 64),
              TextField(
                style: TextStyle(color: Theme.of(context).primaryColorLight),
                decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle:
                      TextStyle(color: Theme.of(context).primaryColorLight),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColorLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                style: TextStyle(color: Theme.of(context).primaryColorLight),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle:
                      TextStyle(color: Theme.of(context).primaryColorLight),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColorLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                style: TextStyle(color: Theme.of(context).primaryColorLight),
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle:
                      TextStyle(color: Theme.of(context).primaryColorLight),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColorLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                style: TextStyle(color: Theme.of(context).primaryColorLight),
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
                  labelStyle:
                      TextStyle(color: Theme.of(context).primaryColorLight),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColorLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  onPressed: () {
                    // Falta desenvolver forma de salvar cadastro
                  },
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () =>
                    Navigator.pop(context), // Navegar de volta ao login
                child: Text(
                  "Já possui uma conta? Entrar",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
