import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tickets4devs/models/Ticket.dart';
import 'package:tickets4devs/notifiers/UserNotifier.dart';
import 'package:http/http.dart' as http;
import 'package:tickets4devs/notifiers/WalletNotifier.dart';
import 'package:tickets4devs/screens/UserTicketDetail.dart';
import 'package:tickets4devs/widgets/BottomNavBar.dart';

class WalletScreen extends StatefulWidget {


  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();

}

class _WalletScreenState extends State<WalletScreen> {

  final int _selectedIndex = 0;
  List<Ticket> _tickets = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

    Future<void> _fetchEvents() async {
    try {
      const String firebaseUrl =
          'https://tickets4devs2024-default-rtdb.firebaseio.com/tickets.json';

      final response = await http.get(Uri.parse(firebaseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        setState(() {
          _tickets = data.entries
          .where((entry) => entry.value != null)
          .map((entry) {
            final userData = entry.value;
            return Ticket(
              id: entry.key,
              userId: userData['userId'] ?? '',
              eventId: userData['eventId'] ?? '',
              purchaseDate: userData['purchaseDate'] ?? '',
              price: userData['price'] ?? '',
            );
          }).toList();
          log('datasaLKDJGLADKGJLKSDGJ: $_tickets');
        });
      } else {
        throw Exception('Erro ao carregar tickets: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        var errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final walletNotifier = Provider.of<WalletNotifier>(context);
    final List<Ticket> walletItems = Provider.of<WalletNotifier>(context).tickets;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Tickets'),
      ),
      body: walletNotifier.tickets.isEmpty ? 
          const Center(
            child: Text('Nenhum ticket comprado!',
                      style: TextStyle(color: Colors.white),
                  )
          ) :
          ListView.builder(
            itemCount: walletNotifier.tickets.length,
            itemBuilder: (context, index) {
              final ticket = walletNotifier.tickets[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('${ticket.eventId}', style: TextStyle(fontWeight: FontWeight.w500),),
                  subtitle: Text(
                    'Comprado em: ${ticket.purchaseDate.toLocal().toString().split(' ')[0]} \nPreço: R\$ ${ticket.price.toStringAsFixed(2)}',
                  ),
                  isThreeLine: true,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => 
                          UserTicketDetail(
                            titulo: ticket.eventId,
                            dataCompra: ticket.purchaseDate.toLocal().toString().split(' ')[0],
                            preco: ticket.price
                          ),
                      )
                    );
                  },
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
