// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FirstScreenPage extends StatelessWidget {
  const FirstScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF030303), // Cor secundária como fundo
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bem-vindo ao Tickets4Devs!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFdbfc3b), // Cor primária no texto
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Os melhores eventos!',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFfefefe), // Cor terciária no subtítulo
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFdbfc3b), // Cor primária no botão
                    foregroundColor: Color(0xFF030303), // Cor secundária no texto do botão
                  ),
                  onPressed: () {
                    context.go('/login');
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}