// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tickets4devs/notifiers/UserNotifier.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserNotifier>(context, listen: false).fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserNotifier>(
        builder: (context, userNotifier, child) {
          if (userNotifier.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (userNotifier.error != null) {
            return Center(child: Text('Erro: ${userNotifier.error}'));
          } else {
            return LoginForm(userNotifier: userNotifier);
          }
        },
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final UserNotifier userNotifier;

  LoginForm({required this.userNotifier});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: 
      Consumer<UserNotifier>(
        builder: (context, value, child){
           return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tickets4Devs",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 64,
                  ),
                  TextField(
                    controller: emailController,
                    style: TextStyle(color: Theme.of(context).primaryColorLight),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Theme.of(context).primaryColorLight),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColorLight),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(color: Theme.of(context).primaryColorLight),
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: TextStyle(color: Theme.of(context).primaryColorLight),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColorLight),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      onPressed: () {
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();

                        if (userNotifier.login(email, password)) {
                          context.go('/home');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('E-mail ou senha incorretos!'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Text(
                        'ENTRAR',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/signup');
                    },
                    child: Text(
                      "CADASTRO"
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
