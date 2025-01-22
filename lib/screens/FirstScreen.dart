// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickets4devs/notifiers/Cart.dart';
import 'package:tickets4devs/notifiers/UserNotifier.dart';
import 'package:tickets4devs/screens/HomeScreen.dart';
import 'package:tickets4devs/screens/LoginScreen.dart';

class FirstScreenPage extends StatelessWidget {


  const FirstScreenPage({super.key});
  
  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    return email != null && password != null;
  }

  Future<void> _navigate(BuildContext context) async {
    final userNotifier = Provider.of<UserNotifier>(context, listen: false);
    final cartNotifier = Provider.of<Cart>(context, listen: false);
    
    await userNotifier.fetchUsers();
    
    final isLoggedIn = await checkLoginStatus();
    if (isLoggedIn) {
      final prefs = await SharedPreferences.getInstance();
      final String email = prefs.getString('email')!;
      final String password = prefs.getString('password')!;

      if (userNotifier.login(email, password)) {
        cartNotifier.syncCart(userNotifier.userLogado);
        context.go('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _navigate(context);
    return Scaffold(
      backgroundColor: Color(0xFF030303), // Cor secundária como fundo
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
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
      ),
    );
  }
}