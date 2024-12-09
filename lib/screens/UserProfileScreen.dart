// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tickets4devs/widgets/BottomNavBar.dart';
import 'package:tickets4devs/notifiers/UserNotifier.dart';
import 'package:tickets4devs/notifiers/Cart.dart';

class UserProfileScreen extends StatelessWidget {

  final int _selectedIndex = 0;

  final String name;
  final String email;

  const UserProfileScreen({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(30.0),
                ),
              ),
              child: AppBar(
                title: Center(
                  child: Text(
                    'Perfil do Usuário',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).primaryColorLight,
              child: Icon(
                Icons.person,
                size: 60,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                Text(
                  ' $name',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                Text(
                  ' $email',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                onPressed: () {
                  Provider.of<UserNotifier>(context, listen: false).deslogar();
                  Provider.of<Cart>(context, listen: false).clearCard();
                  context.go('/');
                },
                icon: Icon(Icons.logout),
                label: Text("Sair da Conta"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
