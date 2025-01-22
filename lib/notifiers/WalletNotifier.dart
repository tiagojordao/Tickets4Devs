import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tickets4devs/models/Ticket.dart';
import 'package:http/http.dart' as http;

class WalletNotifier extends ChangeNotifier {

  List<Ticket> _tickets = [
    Ticket(
      id: '1',
      userId: '1',
      eventId: 'Apresentação',
      purchaseDate: DateTime.now(),
      price: 10,
    )
  ];
  get tickets => _tickets;

  Future<void> fetchUsers() async {
    try {
      const String firebaseUrl =
          'https://tickets4devs2024-default-rtdb.firebaseio.com/tickets.json';

      final response = await http.get(Uri.parse(firebaseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body); 
          
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
        notifyListeners();
      } else {
        throw Exception('Erro ao carregar eventos: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

}