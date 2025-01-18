// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tickets4devs/notifiers/UserNotifier.dart';
import 'package:tickets4devs/notifiers/Cart.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserNotifier>(
      builder: (context, value, child) {
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
                  onPressed: () => context.go('/home'),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () => context.go('/search'),
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () => context.go('/cart'),
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () {
                    context.go('/profile');
                  }
                ),
                IconButton(
                  icon: Icon(Icons.wallet_sharp),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () {
                    context.go('/wallet');
                  }
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () => context.go('/create_event'),
                ),
                IconButton(
                  icon: Icon(Icons.logout),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () { value.deslogar(); Provider.of<Cart>(context, listen: false).clearCard(); context.go('/');}
                ),
              ],
            ),
          ),
        ),
      );
      },
    );
  }
}
