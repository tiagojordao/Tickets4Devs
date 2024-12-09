import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tickets4devs/notifiers/UserNotifier.dart';
import 'package:tickets4devs/notifiers/Cart.dart';
import 'package:tickets4devs/widgets/BottomNavBar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double total = 0.0;
    final int _selectedIndex = 0;

    final cartNotifier = Provider.of<Cart>(context);
    final userNotifier = Provider.of<UserNotifier>(context);

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
                title: const Center(
                  child: Text(
                    'Carrinho de Compras',
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
      body: Consumer<Cart>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: value.cartItems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          title: Text(
                            value.cartItems[index].title,
                            style: const TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'R\$${value.cartItems[index].price.toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14.0),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.cancel,
                                color: Color.fromRGBO(162, 194, 73, 1)),
                            onPressed: () {
                              value.removeItemFromCartById(
                                  value.cartItems[index].id);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Color.fromRGBO(162, 194, 73, 1),
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'R\$${value.calculateTotal()}',
                              style: const TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor:
                                Theme.of(context).primaryColorLight,
                            side: BorderSide(
                                color: Theme.of(context).primaryColorLight,
                                width: 2.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            textStyle: const TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.w400),
                            elevation: 0,
                          ),
                          onPressed: value.cartItems.isEmpty
                              ? null
                              : () {
                                  cartNotifier.purchaseTickets(userNotifier.usuarioLogado.id);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Compra Finalizada'),
                                        content: const Text(
                                            'O ingresso foi enviado para sua caixa de e-mail!'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Fechar',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      162, 194, 73, 1)),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                          child: const Text('Finalizar Compra'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            height: 4,
            thickness: 2,
            color: Colors.black,
          ),
          BottomNavBar(
            selectedIndex: _selectedIndex,
          ),
        ],
      ),
    );
  }
}
