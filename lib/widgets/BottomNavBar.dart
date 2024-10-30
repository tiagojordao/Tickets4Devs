// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      child: Container(
        height: 70,
        color: Theme.of(context).primaryColor,
        child: BottomAppBar(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home),
                color: Theme.of(context).scaffoldBackgroundColor,
                onPressed: () => context.go('/'),
              ),
              IconButton(
                icon: Icon(Icons.search),
                color: Theme.of(context).scaffoldBackgroundColor,
                onPressed: () => context.go('/search'),
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart),
                color: Theme.of(context).scaffoldBackgroundColor,
                onPressed: () => context.go(
                    '/'), /*Temos que alterar para a tela de carteira quando houver*/
              ),
              IconButton(
                icon: Icon(Icons.person),
                color: Theme.of(context).scaffoldBackgroundColor,
                onPressed: () => context.go(
                    '/'), /*Temos que alterar para a tela de perfil quando houver*/
              ),
              IconButton(
                icon: Icon(Icons.add),
                color: Theme.of(context).scaffoldBackgroundColor,
                onPressed: () => context.go('/create_event'),
              ),
              IconButton(
                icon: Icon(Icons.logout),
                color: Theme.of(context).scaffoldBackgroundColor,
                onPressed: () => context.go('/'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
