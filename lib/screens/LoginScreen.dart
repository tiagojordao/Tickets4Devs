// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tickets4devs/routes/Routes.dart';

class LoginScreen extends StatelessWidget {
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
                    context.go('/search');
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
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
